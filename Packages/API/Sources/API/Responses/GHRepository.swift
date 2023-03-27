//
//  GHRepository.swift
//  
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation

public struct GHRepository: Decodable, Hashable, Identifiable {
    public init(id: Int) {
        self.id = id
    }
    
    public var id: Int
}
