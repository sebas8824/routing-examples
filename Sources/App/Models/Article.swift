//
//  Article.swift
//  App
//
//  Created by Sebastian on 10/14/18.
//

import Foundation
import Vapor

struct Article: Parameter, Content {
    
    var id: Int
    var title: String
    
    init(id: String) {
        if let intID = Int(id) {
            self.id = intID
            self.title = "Customer parameters rock!"
        } else {
            self.id = 0
            self.title = "Unknown article"
        }
    }
    
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Future<Article?> {
        return Future.map(on: container) {
            Article(id: parameter)
        }
    }
}
