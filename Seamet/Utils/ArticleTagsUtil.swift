//
//  ArticleTagsUtil.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import Foundation

struct ArticleTagsUtil {
    static func articleTagsToString(tags: [String]) -> String {
        return tags.joined(separator: " / ")
    }
}
