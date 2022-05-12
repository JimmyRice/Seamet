//
//  DatetimeUtil.swift
//  Seamet
//
//  Created by Jimmy on 5/13/22.
//

import Foundation

enum DatetimeUtilError: Error {
    case convertToDateError
}

struct DatetimeUtil {
    static func ISO8601ToString(dateTime: String) throws -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let updatedDate = dateFormatter.date(from: dateTime) else {
            throw DatetimeUtilError.convertToDateError
        }
        
        let iso8601InString = dateFormatter.string(from: updatedDate)
        
        return iso8601InString
    }
}
