//
//  GHOwner.swift
//  
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation

public struct GHOwner: Decodable, Hashable, Identifiable {
    public init(id: Int, login: String, avatarUrl: URL? = nil) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
    }
        
    public let id: Int
    public let login: String
    public let avatarUrl: URL?
}
