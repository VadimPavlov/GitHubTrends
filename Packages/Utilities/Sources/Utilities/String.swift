//
//  String.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation

public extension String {
    func regex(pattern: String) throws -> [String] {
        let nsString = self as NSString
        let regex = try NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
        return matches.map { result in
            nsString.substring(with: result.range)
        }
    }
}
