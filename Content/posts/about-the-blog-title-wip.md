---
title: Full Transparency and Launch Post
slug: about-the-blog-title-wip
date: 2019-05-08 09:41
date_updated: 2019-06-03T08:05:46.000Z
tags: blog, inuk entertainment
description: We recently launched this blog, with Bastian's WWDC Wish, and some impressive page visits. We, Wesley and I, want full transparency between you, the reader, and us, so here's a small post on some decisions from the beginning.
---

We recently launched this blog, with [Bastian's WWDC Wish](https://inuk.blog/bastians-wwdc19-wish/), and [some impressive page visits](https://simpleanalytics.io/inuk.blog/). We, [Wesley](https://www.inuk.blog/author/hillytech) and [I](https://www.inuk.blog/author/bastian), want full transparency between you, the reader, and us, so here's a small post on some decisions from the beginning.

## Why did we choose Ghost as our CMS?

Originally I wanted to make my own CMS, I once before made a simple blogging CMS in [Vapor](http://vapor.codes), which I later threw out the window. So I thought I could do it again in a short amount of time, but the task quickly became daunting. But I really wanted to launch the site so I could get Wesley onboard from the get-go. I started without a CMS, and I don't like the admin panel of [WordPress](wordpress.org), I wanted something self-hosted. I decided on [Ghost](https://ghost.org/), as I know one [using it](https://www.milanvit.net/), and being happy with it.

I didn't know much I'd love the CMS before installing it, my thought was to slowly replace parts, which I still might, as Ghost is much more modular than initially thought!

As an example of the modular structure; I am currently writing an [Apple News publisher for Ghost](https://github.com/Human-Entertainment/AppleNewsPusher), so we can easily push to Apple News, while just using a single front end. [Ghost's API](https://docs.ghost.org/api/?_ga=2.177940391.300750195.1557213044-1884705885.1554712874) is exhaustive enough that it's possible to change the admin panel, make a custom front end, and suddenly Ghost is just an interface to a database. According to Ghost's website, big sites like [Apple Newsroom](https://www.apple.com/newsroom/) is using Ghost, but that's not fully apparent on their site, which show's the extensibility of Ghost, or rather how easy it is to include Ghost in your current project. 

### Apple News Publisher

The flow of the publisher tool I'm writing will begin it's cycle with a text editor with [Markdown support](https://daringfireball.net/projects/markdown/), and uploaded to Ghost, [which also supports Markdown](https://blog.ghost.org/markdown/). When the article is published, [a Webhook](https://docs.ghost.org/api/webhooks/) will be activated on a different server. The server then asks Ghost for a [list of all published articles](https://docs.ghost.org/api/content/#posts), parses that and pushes to [Apple News](https://developer.apple.com/news-publisher/).

In the future, I might make a publishing platform. This platform will send [to Ghost](https://docs.ghost.org/api/admin/#creating-a-post) as well as Apple News, for better control, as Ghost's Webhooks only does [basic get requests](https://www.w3schools.com/tags/ref_httpmethods.asp).

I might not remove Ghost completely, but I could see myself playing with the modules for fun, while keeping the stable parts intact, until my fun becomes stable.

In the future, I'll also plan to make an [ActivityPub](https://en.wikipedia.org/wiki/ActivityPub) translation layer, and maybe even release these tools for a source of income, if interest arise.

## Monetization

Wesley and I hope to, in the near future, be making a decent penny for this project.

Part of why we want to publish to Apple News, is to get a revenue stream. We're also discussing various other revenue streams, sponsored content, ads, affiliate links and stuff like that.

## Analytics

For analytics we use [SimpleAnalytics](https://referral.simpleanalytics.com/bastian-inuk-christensen), as they have a [lucrative privacy policy](https://simpleanalytics.io/privacy), something [we highly value](https://inuk.blog/privacypartone/). I feel confident in their privacy policy, due to the service [not being a free service](https://simpleanalytics.io/#signup). I have decided to keep the analytics [open for anyone to see](https://simpleanalytics.io/inuk.blog/) for the sake of full transparency.

If you've got any questions, you're welcome to contact [Wesley](https://twitter.com/HilliTech) or [I](https://twitter.com/BastianInuk) on twitter.
