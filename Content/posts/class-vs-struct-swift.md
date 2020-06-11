---
title: Class vs Struct Swift
slug: class-vs-struct-swift
date: 2020-03-09 20:31
date_updated: 2020-03-09T20:31:47.000Z
tags: swift, coding, Education
---

There are a few meta-types in Swift, two of which looks similar at phase value. But the difference can really end up biting you if you're not careful. But what exactly is the difference?

## Pass by Reference vs. Value

The difference between Class and Struct basically boils down to what `a` prints in following sample:
```swift
    var a: Foo = Foo(bar: 1)
    var b = a
    	b.bar += 1
    print(a.bar)
```

In a case where `Foo` is a class, `b` and `a` references the same object, this is becaus class is pass by reference. This means modifying `b` also directly modifys `a`, and as such, `a.bar` is now 2.

Structs on the other hand are pass by value, meaning the object of `a` is getting copied into `b`

## When should I use either?

Due to this behaviour, I personally prefer to use class to represent external data. This external data includes,

- databse table ([fluent](https://theswiftdev.com/a-tutorial-for-beginners-about-the-fluent-postgresql-driver-in-vapor-4/)).
- external files and [books](https://github.com/Human-Entertainment/BookKit/blob/master/Sources/EpubKit/ePub.swift)
- windows.

All these changes at times, and beyond the developers control, as such I like to represent them as classes in my code, as references.

For everything else, I use structs wherever it makes semanthic sense to me. So that's data that's inside the app.
