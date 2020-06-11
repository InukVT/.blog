---
title: Siblings in Fluent 4
slug: fluent-in-siblings
date: 2020-02-03 17:52
date_updated: 2020-02-03T19:39:07.000Z
tags: coding, Education, how to, linux, swift, vapor
description: Siblings are not difficult to work with in Fluent 4, so here's a short how-to.
---

If you've read [my other Vapor 4 posts](https://www.inuk.blog/tag/vapor/), chance is that you use Vapor 4 yourself, and if that's the case you might have found yourself looking for sibling (many to many) relations between models.

Siblings in Fluent 4 is really easy to work with, once you get the hang of property wrappers. To get siblings working we need a pivot model, and if we take an example of users who owns books, we can have the following pivot:
```swift
    final class UsersBooks: Model {
        static let schema = "usersbook"
        
        @ID(key: "id")
        var id: Int?
        
        @Parent(key: "user_id")
        var user: User
        
        @Parent(key: "book_id")
        var book: Book
        
        init() {}
        
        init(userID: Int,"bookID: Int) {
            self.$book.id = bookID
            self.$user.id = userID
        }
    }
```

With each `@Parent` being the the models that needs to be related. This pivot allows us to bind multple books to multiple users, which I intend to use as books aren't exclusive to single users. Before we can bind this pivot to it's respective models, we also need to make a migration, I do it as follows:
```swift
    extension UsersBooks {
        struct Migration: Fluent.Migration {
            let name = UsersBooks.schema
            
            func prepare(on database: Database) -> EventLoopFuture<Void> {
                database.schema(UsersBooks.schema)
                    .field("id", .int, .identifier(auto: true))
                    .field("user_id", .int, .required)
                    .field("book_id", .int, .required)
                    .create()
            }
            
            func revert(on database: Database) -> EventLoopFuture<Void> {
                database.schema(UsersBooks.schema).delete()
            }
        }
    }
```

And remember to register it in `configure.swift` like you would any model. When this is all done, it's timne to add these to the models that needs to be glued together:
```swift
    final class User: Model, Content {
        static let schema = "users"
        
        @ID(key: "id")
        var id: Int?
    
        @Field(key: "email")
        var email: String
    
        @Field(key: "password_hash")
        var passwordHash: String
        
        @Field(key: "userRole")
        var role: UserRoles
        
        @Siblings(through: UsersBooks.self, from: \.$user, to: \.$book)
        var books: [Book]
    
        init() { }
    
        init(id: Int? = nil, name: String, email: String, passwordHash: String, role: UserRoles = .everyone) {
            self.id = id
            self.email = email
            self.passwordHash = passwordHash
            self.role = role
        }
    }
    
    ...
    
    final class Book: Model, Content {
    	static let schema = "books"
    
    	@ID(key: "id")
    	var id: Int?
    
    	@Field(key: "title")
    	var title: String
    
    	@Siblings(through: UsersBooks.self, from: \.$book, to: \.$user)
    	var owners: [User]
    
    	init() {}
    
    	init(id: Int? = nil, title: String) {
    		self.id = id
    		self.title = title
    	}
    }
```

Note that `from` is the parent relation pointing to the current model, and `to` is the parent relation pointing to the related model. These two parent relations create a link from the current model to the target model via the pivot model. The siblings are not in the initilsation due to how they work in fluent, they're eager loaded which basically means they're automatically fetched by fluent on request.

Now that we have all this in place, we can finally find all books of a given user with the following:
```swift
    func usersCollection(req: Request) throws -> EventLoopFuture<[Book]> {
        let userID: User.IDValue? = req.parameters.get("id")
        return User
            .find(userID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                try! $0.$books
                        .query(on: req.db)
                        .all()
            }
    }
```

While the `try!` looks scary, there is no need to worry; if there is no books for a given user, it'll just return `[]`, and we no there's a database connection because of earlier connection. When we need to attach a book to a owner, this method is what it takes:
```swift
    func addBook(req: Request) throws -> EventLoopFuture<[Book]> {
        guard let userID: User.IDValue = req.parameters.get("id") else { throw Abort(.notFound) }
        guard let bookID: Book.IDValue = try? req.content.decode(Book.PurchaseContent.self).id else { throw Abort(.notFound) }
        _ = UsersBook(userID: userID, bookID: bookID).save(on: req.db)
        return try self.usersCollection(req: req)
    }
```

It's worth considering making an extension to the model `User` with this function, so we don't need to pass parameters around. The `_ =` is to silence a warning, and I return `usersCollection` because I want to return something, alternatively it's worth consider return `200 success` or something to the like.

## Special Thanks

[Tanner Nelson](https://github.com/tanner0101) for provding help on the [Discord](https://discordapp.com/invite/vapor).
