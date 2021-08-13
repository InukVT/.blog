---
title: Plot in Vapor
slug: plot-and-vapor
date: 2020-01-21 06:27
date_updated: 2020-02-03T19:05:47.000Z
tags: apple, coding, WWDC, vapor
description: Plot + Vapor = <3
---

[John Sundell](https://www.swiftbysundell.com) has released his DSL for HTML written Swift [Plot](https://github.com/JohnSundell/Plot). You may have wondered "how do I make it work with Vapor?" as did I, when I found [this article](https://medium.com/@andreabellotto88/how-to-use-plot-in-vapor-3-0-404316ce24c0) telling how to make this work. The article is written for Vapor 3 and I want to focus on Vapor 4.

For beginner we need to make sure that we can even use Plot, to to this, add Plot to you Package.swift:
```swift
    let package = Package(
      name: "Manga",	
      dependencies: [
        ...
        .package(url: "https://github.com/JohnSundell/Plot.git", from: "0.5.0")
        ...	
      ],
      targets: [
        .target(name: "App", dependencies: [
        	...
        	"Plot",
        	...
      	]),
      ...
      ]
    )
```    

You can now begin using Plot when you pulled in your packages. The clever and impatient might notic that `func myRouter(req:) throws -> EventLoopFuture<HTML>` is going throwing compile errors, so to support the `EventLoopFuture<HTML>` we need to extend `HTML` and add two functions like so:

```swift
    import Plot
    import Vapor
    
    extension HTML: ResponseEncodable {
            public func encodeResponse(for request: Request) -> EventLoopFuture<HTML> {
            request.eventLoop.submit{self}
        }
        
        public func encodeResponse(for req: Request) -> EventLoopFuture<Response> {
            let res = Response(headers: ["content-type": "text/html; charset=utf-8"], body: .init(string: self.render()))
            return res.encodeResponse(for: req)
        }
    }
```    

The first functions allows us to easily write a route that looks a little something like, and omit the `.render()` as that'be handled by the eventloop.

```swift
    func myRoute(req: Request) throws -> EventLoopFuture<HTML> {
        HTML(.body(.p("Hello World!"))).encodeResponse(for: req)
    }
```

But without the latter function, we can't conform to `ResponseEncodable` which is important for the `EventLoopFuture`. The function also handles rendering the HTML for us, so we don't have to. And now you've added this extension, you can use  Plot as much as you want in Vapor 4, just remember to chain `.encodeResponse(req)`!

Thanks to the [Vapor Discord]([https://discordapp.com/invite/vapor](https://discordapp.com/invite/vapor) for typo fixes.
