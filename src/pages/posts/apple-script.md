---
layout: ../../layouts/ArticleLayout.astro
title: "the anatomy of applescript syntax"
date: 18/09/2024
---
 I’ve recently been developing a library to streamline macOS application automation, motivated largely by Apple’s reluctance to fully port the iOS Shortcuts Automation framework to macOS. Apple’s official recommended approach involves the macOS Shortcuts app in tandem with Automator, a cumbersome and outdated setup without any support for managing multiple automations simultaneously. Various community workarounds have emerged, like scheduling recurring iCalendar events to trigger shortcuts or using bash scripts with cron jobs. However, certain shortcuts require admin privileges, which in turn prompt users for password or biometric authentication, which unfortunately cannot be disabled or pre-approved in macOS. This led me to devise a solution to automate these authentication prompts, which appear as unfocusable GUI windows. My idea was to detect when a window appeared, verify if it was the authentication prompt, and fill out the username and password fields automatically. Initially, I thought Apple’s Swift programming language would contain the necessary libraries for scripting and window management tasks. However, Swift remains limited in its scripting tooling for macOS operations.

## history

To understand AppleScript's history, I’d refer to a fantastic paper by William Cook from the University of Texas at Austin which thoroughly examined its development. In essence, AppleScript was designed to be a scripting language meant for widespread use. To enhance readability, it adopted a natural language syntax and supported multiple languages, including English, Japanese, and French. Its primary goal was to “automate complex tasks and customize macOS applications.” AppleScript attempted to achieve this through “Apple Events,” a specialized form of remote procedure calls. With Apple Events, outgoing messages from a script pre-identified their arguments which allowed the receiving application to interpret commands directly without using remote object pointers or proxies. It reduced the need for communication round trips, which were too computationally expensive on older Macintosh systems. Applications supporting AppleScript’s Open Scripting Architecture let users link scripts to application objects to capture and modify application behaviour. Though ambitious, AppleScript’s implementation ultimately fell very short because it prioritized readability over extensibility.

## syntax

For reference, here is AppleScript’s grammar:

```
reference ::=
    |  property
    |  ‘beginning’
    |  ‘end’
    |  ‘before’ term
    |  ‘after’ term
    |  ‘some’ singularClass
    |  ‘ first ’ singularClass
    |  ‘ last ’ singularClass
    |  term (‘st’ | ‘nd’ | ‘rd’ | ‘th’) anyClass
    |  ‘middle’ anyClass
    |  ( pluralClass | ‘every’ anyClass) [‘ from’ term toOrThrough term]
    |  anyClass term [toOrThrough term]
    |  singularClass ‘ before’ term
    |  singularClass ‘ after ’ term
    |  term (‘of’ | ‘in’ | ‘’s’) term
    |  term (‘whose’ | ‘where’ | ‘that’) term
toOrThrough ::= ‘to’ | ‘thru’ | ‘through’
call ::= message ‘(’ expr∗ ‘)’
    | message [‘ in ’ | ‘ of ’] [ term] arguments | term name arguments
message ::= name | terminologyMessage
arguments ::= ( preposition expression | flag | record)∗
flag ::= (‘with’ | ‘without’) [name]+
record ::= ‘given’ (name ‘:’ expr)∗
preposition ::=
‘to’ | ‘from’ | ‘thru’ | ‘through’
    | ‘by’ | ‘on’ | ‘into’ | terminologyPreposition
```

That is not a typo. AppleScript does infact include slang language like “thru.” Yet, that is far from the only syntactical quirk. For example, if the quantity being referred to is even, does “middle” select the rounded-up or rounded-down index? Does “some” indicate a specific quantity or just a single object? Using possessive syntax like “’s” is utterly ambiguous when referencing objects not typically personified. These syntax choices, intended to improve legibility, ultimately impede the language's potential.

## comparison

To illustrate, let’s consider a simple task: prompting a user to select a directory, then renaming all files in that directory by prefixing them with “new\_”. Here’s the solution in Python:

```
import os
from tkinter import Tk, filedialog

# Hide the root window
root = Tk()
root.withdraw()

# Prompt the user to select a directory
folder_path = filedialog.askdirectory(title="Select folder: ")

# Set the prefix for renaming files
prefix = "new_"

# Check if a folder was selected
if folder_path:
    # Loop through each file and rename
    for filename in os.listdir(folder_path):
        old_path = os.path.join(folder_path, filename)
        new_path = os.path.join(folder_path, prefix + filename)
        os.rename(old_path, new_path)
    print("Renaming completed!")
else:
    print("No folder selected.")
```

Now, here’s the same solution implemented in AppleScript:

```
-- Set the folder path
set folderPath to choose folder with prompt "Select folder: "
set prefix to "new_"

-- List all files in the folder
tell application "Finder"
    set fileList to every file of folder folderPath
end tell

-- Loop through each file and rename
repeat with i from 1 to count of fileList
    set currentFile to item i of fileList
    tell application "Finder"
        set originalName to name of currentFile
        set newName to prefix & originalName
        try
            set name of currentFile to newName
        on error
            display dialog "Error renaming" & originalName giving up after 2
        end try
    end tell
end repeat
display dialog "Renaming completed!" giving up after 2
```

While AppleScript might seem more readable due to its natural language syntax, it generates boilerplate code and unnecessary complexity. Developers are forced to remember specific keyword combinations and work with a bracket system based on keywords rather than typical punctuation which only leads to clunky, bloated scripts. Attempting to write any extensive scripts with AppleScript is impractical, as the language’s design turns what should be straightforward tasks into overly complicated problems.

## readability vs. abstraction

AppleScript is no doubt a cautionary tale about the purpose of programming languages: they serve as layers of abstraction. A language's syntax need not prioritize readability; that responsibility lies with the developer. The best-written code often speaks for itself, requiring minimal comments from intuitive design. AppleScript tried to transfer this responsibility onto the language itself which resulted in its convoluted syntax. Despite its release 30 years ago, Apple continues to support AppleScript in macOS. Although it seems unlikely that the language is still actively developed, Apple’s continued support is surprising. Instead of prolonging AppleScript's life, Apple should consider expanding Swift’s scripting capabilities for native macOS applications. AppleScript serves as a stark reminder that despite how approachable a language may seem, scalability must come first in design. 