//
//  Entry.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

struct Entry<TData: Codable>: Codable {
    let data: TData
}
