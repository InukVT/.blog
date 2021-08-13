---
title: Roles and permissions with Vapor and Fluent
slug: vapor-fluent-4-and-enums
date: 2020-01-27 17:45
date_updated: 2020-01-28T13:40:54.000Z
tags: vapor, coding, swift, apple, linux
description: If you know about enums, you probably also get why they're handy and why I thought about using them for my User model, but but this was too difficult to implement in Fluent 4.
---

If you know about enums, you probably also get why they're handy[manga.dk](manga.dk)and why I thought about using them for my `User` model, but but this was too difficult to implement in Fluent 4.

## What is an enum?

It differs between languages, but in short it's a way for a programmer to restrict the amount of values a variable can have. If we take following Swift enum, we can better show the *power* of this restriction:
```swift
    enum UserRole {
        case admin
        case user
    }
    
    var userRole: UserRoles
```

With this enum `UserRoles` the variable `userRole` can only be either admin or user, and the compiler will *yell* at you for even considering other values.

## Come OptionSets

Sometimes we need to turn on and off features individually instead of having entire and heavy roles. Meet [OptionSets](https://developer.apple.com/documentation/swift/optionset), a non-exlusion err.. set. We at Inuk Entertainment (I) have decided that OptionSet is the better choice for Manga.dk's CMS, and besides it allowing for more granular controle, it also plays much nicer with Fluent 4 than enums did. To make it work with Fluent 4, we have to conform it to `Codable` and add our own encoding and init as following.
```swift
    struct UserRights: OptionSet, Codable {
        init(rawValue: UInt64) {
            self.rawValue = rawValue
        }
        
        init(from decoder: Decoder) throws {
          rawValue = try .init(from: decoder)
        }
        
        func encode(to encoder: Encoder) throws {
          try rawValue.encode(to: encoder)
        }
        
        let rawValue: UInt64
    }
```

And when Fluent 4 asks, our optionset is UInt64 (this allows for 64 different options to turn on and off) and will look as follows in migration:
```swift
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(name)
            .field("id", .int, .identifier(auto: true))
            .field("name", .string, .required)
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .field("userRights", .uint64, .required )
            .create()
    }
```

This migration assumes my user model, which looks like this and has the OptionSet included below.
```swift
    final class User: Model, Content {
        static let schema = "users"
        
        @ID(key: "id")
        var id: Int?
        
        @Field(key: "name")
        var name: String
    
        @Field(key: "email")
        var email: String
    
        @Field(key: "password_hash")
        var passwordHash: String
        
        @Field(key: "userRights")
        var userRights: UserRights
    
        init() { }
    
        init(id: Int? = nil, name: String, email: String, passwordHash: String, userRights: UserRights = .everyone) {
            self.id = id
            self.name = name
            self.email = email
            self.passwordHash = passwordHash
            self.userRights = userRights
        }
    }
    
    struct UserRights: OptionSet, Codable  {
        init(rawValue: UInt64) {
            self.rawValue = rawValue
        }
        
        let rawValue: UInt64
        
        func encode(to encoder: Encoder) throws {
          try rawValue.encode(to: encoder)
        }
        
        init(from decoder: Decoder) throws {
          rawValue = try .init(from: decoder)
        }
        
        /// This is a given user, used for default Init in User
        static let everyone: Self = []
        /// Anyone with this priv can change a different user
        static let modUser = Self(rawValue: 1 << 1)
        /// This user can edit and add books to the system
        static let mangaUpload = Self(rawValue: 1 << 2)
        
        /// Has all the rights, you shouldn't check on this, only make a user super admin, also don't use .max, it will crash the system for currently unknown reasons
        static let superAdmin = Self(rawValue: 1 << 0)
    }
```
    
Let's unravel a given option `static let mangaUpload = Self(rawValue: 1 << 2)`.  Static means it can be called without initialising the model it's part of, `Self` is a way to initialise an instance of the type the variable is part of and `1 << 2` is 1 bitshifted 2 which in binary is `100` or 4 in the decimal system. So OptionSets very much prefers a value that is in the power of two, which is why it's much easier to just use bitshifting. This is because when an OptionSet has more than one value, it's "just" added, so `modUser` and `mangaUploader` will be `110`.

When all is set up, it's only a matter of doing checks of wether the user has a given permissiong with `myUser.userRights.contains(.modUser)` if I want to see if the user can mod a different user.
