//
//  Error.swift
//  
//
//  Created by Vadym Pavlov on 29.03.2023.
//

import Foundation

public extension Error {
    var isCancelled: Bool {
        let error = self as NSError
        let codes = [NSURLErrorCancelled, NSURLErrorCannotConnectToHost]
        return codes.contains(error.code)
    }
}
