---
title: SPM, Xcode and Working Directories
slug: spm-xcode-and-working-diroctories
date: 2020-03-26 14:54
date_updated: 2020-03-26T14:54:30.000Z
---

If you've coded Vapor or any other SwiftPM project on mac, you may have found yourself in need of retrieving somethign from a relative path of the working directory. If you run the program from the command line, everything is okay, but Xcode has working directory a weird place. This is a short guide on how to change that.

First: Open the SwiftPM project as you usually do.

Second: Open the scheme editor, this can be done by option clicking the run button:
![](/content/images/2020/03/Screenshot-2020-03-26-at-15.49.42.png)
Third: Navigate to "Working Directory" in Run -> Options. Check the check box and write the absolute path to your project, or wherever you want the working directory to be at!
![](/content/images/2020/03/Screenshot-2020-03-26-at-15.50.19.png)
That's all really, remember this is a user setting, and should be set by everyone who uses Xcode in your team. It's not embarrassing to forget to set this on new projects, I unfortunately do that all the time 😅
