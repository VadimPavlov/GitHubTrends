//
//  Repository.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//
import UI
import API
import SwiftUI
import Database

public extension Repository {
    var decsription2: String {
        desc ?? "Description is not found"
    }
}

extension GHRepository: Repository {
    public var created: Date? {
        createdAt
    }
        
    public var author: String? {
        owner.login
    }
    public var avatarUrl: URL? {
        owner.avatarUrl
    }
    
    public var desc: String? {
        description
    }
    
    public var stars: Int {
        stargazersCount
    }
}

extension CDRepository: Repository {
    public var id: Int {
        Int(self.intID)
    }
    
    public var stars: Int {
        Int(self.intStars)
    }
    
    public var forks: Int {
        Int(self.intForks)
    }
        
    public var created: Date? {
        createdAt
    }
    
}

extension RepositoryCell {
    init(repository: Repository) {
        self.init(title: repository.name, author: repository.author, avatar: repository.avatarUrl,
                  description: repository.decsription2, stars: repository.stars)
    }
}
