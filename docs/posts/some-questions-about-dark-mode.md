---
title: Some Questions About Dark Mode
slug: some-questions-about-dark-mode
date: 2019-05-02 16:01
date_updated: 2019-05-02T20:44:59.000Z
tags: iOS, WWDC, blog, dark mode
description: Dark mode is coming, but what does that mean for users?
---

Yes, we all know that [dark mode](https://9to5mac.com/2019/04/15/ios-13-features-dark-mode/) is coming. But something I have not seen being discussed is how it will be implemented. Dark mode as a system setting will change how iOS apps work, and could impact monetization targets. I am writing to pose some questions about dark mode to get us thinking more about the feature going into WWDC.

I have had a small obsession with finding apps with a dark mode. Even when on iPad, where I do not have the [benefit of OLED](https://electronics.howstuffworks.com/oled5.htm), I have found that I prefer gray color schemes. It feels easier on the eyes and does not light up a dim room with a bright white background. Gaining dark mode as a system setting will be a huge boon, especially when considering how blinding some apps can be.

Most apps hide their alternate color schemes behind a paid subscription or in app purchase. How will that change with iOS 13:

- Will system wide dark mode apply a filter across the OS and ignore dark mode apps? (I don't think so)
- Will it be a targeted API that will respect a toggle in system settings? (Maybe)
- Will it be a system settings menu that is like notifications where you go through and toggle dark mode on an app specific basis.(most likely)

I like the idea of a simple toggle in settings that will do an all or nothing dark mode. Then below that toggle have a list of apps that support the dark mode API, and have a toggle that will tell the app to respect or ignore the system setting. This same toggle should be available as a setting in the app.

Another aspect of this: how will Apple respect color schemes? Will apps using the dark mode API be able to choose what gradient the user sees? Most likely Apple will require dark mode choose one of the preset color gradients used in safari reader mode. Customization has never been a strong suit on iOS.
![](/content/images/2019/05/iVBORw0KGgoAAAANSUhEUgAAC50AAAjwCAYAAAAKgq9xAAAACXBIWXMAAAsTAAALEwEAmpwYAAAM-2-4.png)
Even now I am typing this in drafts, which has many color choices and themes, I wonder how this app will be targeted. Will we see the app as a dark mode toggle in settings? Will the app have a menu to select what the dark mode toggle does, like which mode is used and what colors?

I hope we get the best of both worlds. Apple should have a targetable API that triggers either a gray or black mode in the app, then the developer can choose to just use Apple's default. The developer could do more work from there, and have the dark mode toggle trigger a custom setting controllable by the user in the app settings. This is best case scenario for the user and developer.

And my final thought; monetization. Will the API be able to be hidden behind an in app purchase? Or will Apple require dark mode support be a default setting that can't be placed behind paywall? The developer could then in theory make the more customizable settings be an in app purchase.

Regardless of what happens, having default apps like iMessage and News (not available in all countries) in dark mode will be a welcome change. Can't wait for WWDC so I can start testing all of this out. Follow me on [twitter](http://www.twitter.com/hillitech) and check back here for my thoughts on Apple and technology.
