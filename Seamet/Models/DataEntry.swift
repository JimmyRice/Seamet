//
//  Entry.swift
//  Seamet
//
//  Created by Jimmy on 5/8/22.
//

import Foundation

struct DataEntry<TData: Codable>: Codable {
    let data: TData
}
