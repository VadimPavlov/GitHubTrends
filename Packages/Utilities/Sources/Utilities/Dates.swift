//
//  Dates.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation

public extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
