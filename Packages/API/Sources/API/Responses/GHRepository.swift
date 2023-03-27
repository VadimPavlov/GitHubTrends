//
//  GHRepository.swift
//  
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation

public struct GHRepository: Decodable, Hashable, Identifiable {
    public init(id: Int, name: String, description: String, createdAt: Date, htmlUrl: URL, owner: GHOwner, stargazersCount: Int, language: String? = nil, forks: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.createdAt = createdAt
        self.htmlUrl = htmlUrl
        self.owner = owner
        self.stargazersCount = stargazersCount
        self.language = language
        self.forks = forks
    }
    
    public let id: Int
    public let name: String
    public let description: String
    public let createdAt: Date
    public let htmlUrl: URL
    public let owner: GHOwner

    public let stargazersCount: Int
    public let language: String?
    public let forks: Int
}
