//
//  Posts.swift
//  App
//
//  Created by Sebastian on 10/14/18.
//

import Foundation
import Vapor

struct Posts: Parameter, Content {
    
    var id: Int
    var title: String
    
    init(id: Int) {
       self.id = id
        self.title = "Customer parameters wreck!"
    }
    
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Posts {
        if let id = Int(parameter) {
            return Posts(id: id)
        } else {
            throw Abort(.badRequest)
        }
    }
}
