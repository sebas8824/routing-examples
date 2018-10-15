//
//  AdminCollection.swift
//  App
//
//  Created by Sebastian on 10/14/18.
//

import Foundation
import Vapor

final class AdminCollection: RouteCollection {
    func boot(router: Router) throws {
        let article = router.grouped("articles", Int.parameter)
        article.get("read") { req -> String in
            let num = try req.parameters.next(Int.self)
            return "Reading article \(num) as admin"
        }
        article.get("edit") { req -> String in
            let num = try req.parameters.next(Int.self)
            return "Editing article \(num) as admin"
        } }
}
