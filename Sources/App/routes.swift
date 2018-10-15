import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    router.get("hello", "world") { req in
        return "Hola mundo!"
    }
    
    router.get("greetings", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "Greetings, \(name)!"
    }
    
    router.get("read", Int.parameter) { req -> String in
        let number = try req.parameters.next(Int.self)
        return "Read the chapter \(number)"
    }
    
    router.get("posts", Int.parameter, String.parameter) { req -> String in
        let id = try req.parameters.next(Int.self)
        let title = try req.parameters.next(String.self)
        return "Loading article \(id) with title \(title)"
    }
    
    router.get("articles", Article.parameter) { req -> Future<Article> in
        let article = try req.parameters.next(Article.self)
        return article.map(to: Article.self) { article in
            guard let article = article else {
                throw Abort(.badRequest)
            }
            return article
        }
    }
    
    router.get("posts", "v2", Posts.parameter, "json") { req -> Posts in
        return try req.parameters.next(Posts.self)
    }
    
    // MARK: Grouping routes inside a router.group block
    router.group("hola") { group in
        group.get("mundo") { req in
            return "Hello world pal"
        }
        
        group.get("amigo", String.parameter) { req -> String in
            let name = try req.parameters.next(String.self)
            return "Hola amigo \(name)"
        }
    }
    
    // MARK: Grouping routes using router.grouped()
    let article = router.grouped("article", Int.parameter)
    
    article.get("read") { req -> String in
        let num = try req.parameters.next(Int.self)
        return "Reading article \(num)"
    }
    
    article.get("edit") { req -> String in
        let num = try req.parameters.next(Int.self)
        return "Editing article \(num)"
    }
    
    // MARK: Grouping routes using the RoutesCollection protocol
    try router.register(collection: AdminCollection())
    try router.grouped("admin").register(collection: AdminCollection())
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
