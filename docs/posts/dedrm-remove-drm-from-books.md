---
title: "DeDRM: Remove DRM from books"
slug: dedrm-remove-drm-from-books
date: 2020-04-12 20:53
date_updated: 2020-04-12T20:53:40.000Z
tags: drm, home server, books
description: Do you have books behind locks, and want to free them? In this post I'll go through how I remove DRM from my books
---

It can be advantageous to remove DRM from ebooks at times. I like to read my books in specific readers, par example. Fortunately [DeDRM](https://github.com/apprenticeharper/DeDRM_tools) is an easy to use tool, which allows removing DRM from Adobe Digital Editions books. To install simply grab the [latest release](https://github.com/apprenticeharper/DeDRM_tools/releases). You'll also need [Calibre](https://calibre-ebook.com) installed. Then you open preferences in Calibre and navigate to plugins:

![](/content/images/2020/04/Screenshot-2020-04-12-at-22.48.53.png)
From here you press the "load plugin from file" button:

![](/content/images/2020/04/Screenshot-2020-04-12-at-22.49.35.png)
In finder, navigate to the "DeDRM_Plugin.zip" and select that.
![](/content/images/2020/04/Screenshot-2020-04-12-at-22.50.01.png)
Just say "Yes" to the security risc warning. Once the plugin is installed, you simply download your books in ADE, as you usually might, and navigate to their ePub files. Getting the ePub files from ADE is as simple as rigth clicking the book in ADE:

![](/content/images/2020/04/Screenshot-2020-04-12-at-22.52.52.png)
Then you just drag the book into Calibre, and let the plugin seamlessly do its magic. 
