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

public extension Calendar {
    
    func dayAgo() -> Date? {
        date(byAdding: .day, value: -1, to: Date())
    }
    
    func weekAgo() -> Date? {
        date(byAdding: .day, value: -7, to: Date())
    }
    
    func monthAgo() -> Date? {
        date(byAdding: .month, value: -1, to: Date())
    }
}
