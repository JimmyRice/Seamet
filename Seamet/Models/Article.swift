//
//  Article.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

struct Article: Codable, Hashable {
    let id: Int
    let title, createdDate: String
    let tags: [String]?
    let content: String?
    let author: Int?
    let slug: String?
    let category: Int?
}
