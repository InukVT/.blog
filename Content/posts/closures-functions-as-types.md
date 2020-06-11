---
title: "Closures: Functions as types"
slug: closures-functions-as-types
date: 2020-02-24 19:46
date_updated: 2020-02-24T19:46:01.000Z
tags: swift, coding, how to
description: If you've coded Swift for a short while, you may have experienced closures. Here's a short explanation of the concept.
---

If you've coded Swift for a short while, you may have experienced them. They manifest in a few different but ultimately it's just functions as types and values, and it's pretty cool.

A short code sample would be something like:
```swift
    var closure: () -> ()
```

This is a very simple uninitiated closure, which would look like this as a function:
```swift
    func myFunc() 
```

It doesn't take a parameter, and doesn't return one either. There are quite a few great ways to use closures, the one that come to most peoples minds is the following:
```swift
    func someFunctionThatTakesAClosure(closure: (String) -> (Int)) {
    	print(closure("Hello World")) // prints whatever number the closure returns
    }
    
    someFunctionThatTakesAClosure { string in
    	print(string) // this prints "Hello World"
    	return string.count // This will return 11
    }
    
    func printAndCount(string: String) -> Int {
    	print(string)
    	return string.count
    }
    
    someFunctionThatTakesAClosure(closure: printAndCount) // you can also pass in functions as long as it matches the closure, e.g. both `closure` and `printAndReturn` takes a String and return and Int
```

Notice the signature of closure, it matches a func almost as if it's an `func closure(_:String)->String`. This is the signature that `someFunctionThatTakesAClosure` expects, and you can pass in anything as long as it matches. the `{ string in }` captures the parameter, and handles it as the constant `string`, like if we had the signature `(string: String)`.

A different way to handle functions as types would be in types. We can have the type:
```swift
    struct Button {
    	private(set) var action: () -> ()
    	init(action: @escaping () -> ()) {
    		self.action = action
    	}
    }
```

Note the `@escaping` in the initialiser, this is because we're saving it so it sticks around after the function returns, which is what is called "escaping" in Swift

This gives us a type `Button` where each instance has it's own behavior on `action()`. The `private(set)` makes it so that we can't accidentally change a given instance's `action` property. This follow the same rules as with `myFunc`, so I can actually instanciate the button and use th property like so
```swift
    let printOne = Button { print(1) }
    printOne.action() // prints 1
```

And if you've played with Vapor for a bit, you might've noticed something. In Vapor we have the function for making get routes look as following
```swift
    func get<Response>(_ path: PathComponent..., use closure: @escaping (Request) throws -> Response) -> Route where Response : ResponseEncodable
```

There's a lot in this function to unwrap. Let's start from an end, the `<Response>` makes a generic type, which'll be used later. the `use closure: @escaping (Request) throws -> Response` makes it so that the function can be called as: `get("index", use: myRoute)`. This function actually saves the closure to a big array behind the scenes, that gets evaluated on route calls, hence the `@escape`. The return type of the passed in function *has* to be `Response` and conform to `ResponseEncodable` as seen by the `where Response : ResponseEncodable`.

So in short, closures is a way to handle functions (and function signatures) as types, and thus pass functions around as you would instances of types. They're powerful, even not used in an asynchronous matter. And if you've used `.map` you've used closures before.
