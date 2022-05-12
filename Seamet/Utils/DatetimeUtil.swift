//
//  DatetimeUtil.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import Foundation

struct DatetimeUtil {
    static func ISO8601ToString(dateTime: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        guard let updatedDate = dateFormatter.date(from: dateTime) else {
            return "Invlid date"
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let iso8601InString = dateFormatter.string(from: updatedDate)
        
        return iso8601InString
    }
}
