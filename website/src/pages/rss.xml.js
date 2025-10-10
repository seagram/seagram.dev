import rss from "@astrojs/rss";
import { getCollection } from "astro:content";
import sanitizeHtml from "sanitize-html";
import MarkdownIt from "markdown-it";
const parser = new MarkdownIt();

export async function GET(context) {
  const blog = await getCollection("blog");
  return rss({
    title: "seagram.dev RSS feed",
    description: "Cal Seagram's personal blog",
    site: context.site,
    items: blog.map((post) => ({
      title: post.data.title,
      pubDate: post.data.pubDate,
      description: post.data.description,
      link: `/blog/${post.id}/`,
      content: sanitizeHtml(parser.render(post.body), {}),
      ...post.data,
    })),
  });
}
