//
//  Repository.swift
//  
//
//  Created by Vadym Pavlov on 29.03.2023.
//

import Foundation

public protocol Repository {
    var id: Int { get }
    var name: String? { get }
    var desc: String? { get }
    var created: Date? { get }
    var author: String? { get }
    var avatarUrl: URL? { get }
    var htmlUrl: URL? { get }

    var stars: Int { get }
    var forks: Int { get }
    
    var language: String? { get }
}

extension CDRepository {
    
    public static func searchPredicate(text: String) -> NSPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: [
            NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDRepository.name), text),
            NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDRepository.desc), text),
            NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDRepository.author), text),
            NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(CDRepository.language), text)
        ])
    }
    
    func fill(with repo: Repository) {
        self.intID = Int64(repo.id)
        self.name = repo.name
        self.desc = repo.desc
        self.intStars = Int16(repo.stars)
        self.intForks = Int16(repo.forks)
        self.htmlUrl = repo.htmlUrl
        self.createdAt = repo.created
        self.author = repo.author
        self.avatarUrl = repo.avatarUrl
        self.language = language
    }
}
