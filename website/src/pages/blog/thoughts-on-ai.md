---
layout: ../../layouts/ArticleLayout.astro
title: "Thoughts on AI"
description: ""
pubDate: 2025-01-01
---

> Frog put the cookies in a box. "There," he said. "Now we will not eat any more cookies." "But we can open the box" said Toad. "That is true." said Frog.

The following are some of my takes on AI.

---

# Learning in the AI era

I believe AI, in the context of programming, is a tool you should earn the right to use. Not from a standpoint of permission but rather to ensure you develop knowledge at the most important stage of learning: the beginning.

My approach to learning has always centered on three key principles:

1. Learn by asking questions
2. Learn by doing
3. Learn by teaching

For any given topic I'm learning, I use these principles in the same order.

## 1. Learn by asking questions

I ask question who's answer will inventiablly prompt me to ask two or more questions for better understandng. From each of those questions, another two or more and the cycle continues. It forms a binary/ternary tree of questions and answers which delves into a topic from it's high level concepts to low level semantics.

AI is great for asking questions. It's incredibly easy and you can tailor it's output to your specificity. I've found many models are great at predicting what follow questions I may have and automatically generate responses to them. Perplexity AI is scarily accurate in this regards and at times it feels as if it's reading my mind. Unfortunately, that some what defeats the point of me asking questions in the first place. It's not the repition of asking questions that fosters learning, it's identify which question to ask given a set a information. Question formulation requires intuition, creativity, and curiosity. All things LLMs can mimick but not acutally posses. The act of formulating questions is critical is this step of learning. That being said, you can mitigate this inside your user prompt by mentioning "Do not respond with follow questions I may be interested in asking.".

## 2. Learn by doing

There's no way around it. AI will hamper you in this aspect despite seemingly "helping" you. You learn by doing things but by doing things alone. An LLM holding your hand, or in most cases today, carrying you on their back, won't get you anywhere.
I think struggle, confusion, and frustration are the most important aspects of learning. Without them, the aha moment wouldn't hold any weight. It's that struggle-to-aha pipeline that when repeated over and over again, slowly develops your muscle to learn.

With AI, there is no struggle and the aha moment is hard to come by. You can easily pretend to be doing something when you have no true understanding of what you are even doing.

When tempted to use LLMs for programming, I tend to ask myself:

> If push comes to shove and the OpenAI API endpoint is down, what am I capable of?

## 3. Learn by teaching

At this point, I may come across as an AI-hater. But I promise I'm not and I recognize that LLMs can be really useful here.
Take a topic you believe you are well-versed in and tell your favourite chatbot to ask you questions about said topics. Then, ask it to critique your answers. You'll either be pleasantly surprised with your competence or quickly develop a case of imposter syndrome. Either way, it's worth trying because you'll identify gaps in your knowledge you may be ignorant of.

For a topic I'm trying to test my understanding of, I ask myself how I would explain it to a five year old. Not a PHD. level computer scientist or senior developer. They'd already understand the topic far more than me and would be thrown off my a bad explanation. Instead, I ask myself how I would explain things like transfer protocols or concurrency or cache to someone without even knowledge of computers. It doesn't let you hide behind the curtain of buzzwords and assumptions. The extent of your knowledge only goes so far as your ability to communicate it. What good is song written in your head that you can't sing aloud?

Suffice to say, I don't find LLMs to be a productive tool for my learning. I tend to avoid them when possible as to not form a dependency on them and ensure I still follow my three principled approach. That being said, I'd be ignorant to not use them at all. There is not doubt about it, they are here to stay. In the same chatbot user interface? Only time will tell but the fundamental technology will undoubtly continue to evolve even it's growth hasn't surpassed the pace we thought once it would. Remember when GPT-5 was rumored to be the last step before AGI? It didn't exactly pan out that way.

## What to do

With that being said, how should I use AI? I fear that if I don't embrace it now, I may pay for it later by playing a game of catch-up for how to use LLM tooling. But at the same time, if I embrace it now, I won't develop a fundamental understanding of the concepts I'm learning? So, what do I do?

Remember in the 70s when the pocket calculator came out and everyone feared accountants would go out of business? I'm asking this as a question because I wouldn't be born for another 30 years but I do remember hearing something about this. The truth is, they didn't get replaced. People didn't automatically become their own acccountant because they owned a calculator. Instead, amongts all the accountants being hired, those who could use calculators replaced those who couldn't.

I have a suspicion that this will be the case for software developers as well. Companies have made it clear that the usage of AI is not only permitted, but recommened and in some cases, even required. Google and Microsoft both have said over 25% of new code from their developers is written by AI. Now, do I trust these numbers to a tee? Not quite, considering their incentive to promote AI adoption. They are two of the biggest investors/producers of AI technology and investors love hearing these obscure, meaningless measurements in quarterly meetings. But it is reflective of an emerging norm. LLMs can write a lot of code and fast. Put in the hands of a capable developer, it can certainly promote productivity. It seems like the developers who can leverage these tools properly will replace those who can't.

If that is the case, I'm disappointed but I've got no choice but to oblige. I've got to close my eyes and embrace it with open arms.
Now, I won't bite the bullet and start using it to write code for me. That defeats the purpose of trying to learn and why I chose software engineering to study in the first place. Like everyone out there, I love to code so things like vibe-coding and agentic coding have no appeal to me. Instead, I've been using LLMs for research. They are great at exploring industry trends and best practices. You can give it a topic and ask it to generate a full report of the best resources to learn from. Each LLM provider's "Deep Research" mode is great at this.

They are also great at playing devil's advocate for your design decisions. When programming, I try implement my first approach to a problem and take note of any pain points I encounter. If the friction exceeds my ability to implement a solution, I take a step back and ask if I'm going about all this the right way. At that point, it's can be useful to ask an LLM to critique my current approach but instead of directly telling me which other approach to use, respond with questions to prompt my own problem solving.

## Something

All of this is to say, I don't think AI is either of the extremes we are propogated to believe. Yes, I do believe that is it addictive and you can certainly form a depency on it but I don't think it will cause the end of humanity. Yes, it can be seemingly very intelligent and useful but it is far from the general intelligence that AI startups have promised us. It lies somewhere in the middle.
A capable tool to be used like anything else in life: in moderation.

## ADD SOMETHIGN ABOUT LEARNING TO END IT

---

# The JavaScript Framework Index

In recent years, I've noticed a decline in the release of new JavaScript frameworks.
It seems not to long ago where it was almost a complaint amongst web developers. A constant churn of new technologies
to either learn, migrate to, or form a baseless hatred for. It was all quite fun.

So where are all the new frameworks? For some context, here's a breakdown of JavaScript frameworks and their release dates.

2006: jQuery  
2010: Knockout  
2012: AngularJS  
2013: Backbone.js, React, Ember.js, OpenUI5  
2014: Riot.js, Marko  
2015: Preact, Vue  
2016: Aurelia, Next.js, Angular (2+), Svelte  
2017: Inferno, Mithril.js, Hyperapp  
2018: Nuxt, Stimulus, Sail.js, Gatsby  
2019: AdonisJS, Alpine.js  
2021: SolidJS, Remix  
2022: RedwoodJS, Hydrogen, Fresh, Alephjs, Astro, SvelteKit  
2023: Strawberry, Qwik, NueJS, NueKit, SolidStart, Waku  
2024: use-use, Brisa, one, mizu.js  
2025: Lynx, Ripple

We can break down this chart into 3 catagories:

## 1. 2006-2015 - Early Web Development

jQuery, since it's creation, held a near monopoly over web development stacks.
Knockout marked a **\_\_** but it wasn't until AngularJS that web development fundamentally changed.
\_\_\_% of websites today still run on jQuery.
The approach of web dev went from \_**\_ to \_\_\_**. Shortly after AngularJS, React was born and **\_\_**.

## 2. 2016-2022 - The React Takeover

React soon became the defacto JavaScript library. Except, it was more than that. The \_**\_ approach of React
influenced the majority of new frameworks, each offering a product resembling React but with their own \_\_\_\_**.
Luckily, after realizing that React alternatives would be **\_\_**, frameworks shifted to entirely different approaches and usecases.
Things like Alpine.js for **\_\_\_** and Svelte for **\_\_\_\_**. Each carved out a productive, valuable niche.

## 3. 2023-Now - The Death of Frameworks (and much more)

New framework development screetched to a halt. But why?
It could be that **\_** or **\_\_\_** or maybe even **\_\_\_\_**.
All compelling cases. But I'd argue it could be something else. Something entirely seperate from **\_\_** or **\_\_**.

On **\_\_**, the ChatGPT **\_** was released as **\_\_\_\_**. It drew a million users in **\_** (time) and has grown exponentially since.

## Number of ChatGPT users

2022: 1 million

2023: 100 million

2024: 180 million

2025: 830 million

All this being said, it's evident that there exists an inverse relationship between the amount of new JavaScript frameworks released each year and the number of ChatGPT users. The relationship also extends to other LLM providers, of course.
Google's Gemini has 400 million monthly active users and Anthropic's Claude has 20 million.

Funny enough, you can see that there have been more LLM providers created each year since 2022 than there have been JavaScript frameworks.

2022: OpenAI GPT, Cohere Command, Baidu ERNIE

2023: Meta Llama, Anthropic Claude, Google Gemini, Inflection, TII Falcon, Mistral, Alibaba Qwen

2024: DeepSeek, xAI Grok

2025: Perplexity, Databricks, Microsoft Phi

## What does this mean?

But what does this all mean? Is it simply coincedence? I'd think not.
The earliest and most active adopters of LLMs were developers. It's in part why all the earliest LLM providers (\_**\_, \_\_**, \_\_\_) focused on proper code generation over general intelligence. They saw a market segment opening and brought their shovels to the gold rush.

At the time all these developers started using LLMs, industry norms across the web developement stack had already been established. React was the most popular JavaScript library, Tailwind CSS was **\_**, and Node was the most popular runtime. Because of this, the majority of data these LLMs were trained contained said technologies. So when a developer were to ask an LLM to generate code for a website without even a mention of what tech stack to use, it would default to these technologies. Some of this generated code would then end up in public repositories and forums and thus be included in the datasets for future LLM models. You see where this is going.
A snowball effect occurred and 3 years later, if you ask any, and I mean any, AI chatbot to generated web developement code without any specific requirements, it will give you React + Tailwind code and instruct you to use Node.js to run it.

On the surface, this does seem to be inherently wrong. These are all tried and true technologies. Sure, they have their shortcomings and some more than others, however, they're still viable tools for certain workloads for today. But that's the key. _Certain_. We all learned in kindergarden that no matter how hard use try, you can put the triangle-shaped block through the circle shaped-hole. Sure, we all gave it our best shot at the time and probably got our tiny fingers crushed, but we learned from that and seeked out the right circle block we should've used in the first place. But here, in our web dev stack dilema, AI has changed something.
AI has become our kindergarden teacher, who's offered to help us put blocks through holes. Except, they've taken all of our non-triangle blocks and put them on the other side of the room. We could just make the effort to walk over there and get our block backs. Or, our teacher can use their strength to force the one triangle block we have through the hole.

There is no single tool for every job. The reason we were creating all these new frameworks were to solve real problems we were encountering in a more and more demanding internet landscape. We created them because we knew forcing a certain technology to solve a problem it wasn't designed to was a bad decision. Yet somehow, the convinience of these tools robbed us of any motivation to seek alternative solutions. We succumb to their defaults and whatever they are most knowledgable of, causing a feedback loop, encouraging future models to use said defaults increasingly more.

---
