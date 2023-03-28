//
//  GitHubAPI.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation
import Utilities

public final class GitHubAPI: API {
    public let baseURL = "https://api.github.com/"
    public let session = URLSession.shared
    public let decoder = JSONDecoder()
    
    static let shortDF = DateFormatter(dateFormat: "yyyy-MM-dd")

    // MARK: - Seach
    enum Comparison: String {
        case less = "<"
        case greater = ">"
        case equal = "="
    }

    enum SearchSort: String {
        case stars
    }
        
    enum SearchQuery {
        case created(Date, Comparison)
        
        var value: String {
            switch self {
            case .created(let date, let condition):
                return "created:\(condition.rawValue)" + GitHubAPI.shortDF.string(from: date)
            }
        }
    }
        
    func searchRepositories(query: [SearchQuery], sort: SearchSort) async throws -> [GHRepository] {
        let query = query.map { $0.value }.joined(separator: "+")
        let request = try self.request(with: "search/repositories",
                                   params: ["q": query, "sort": sort.rawValue])
        return try await fetch(request: request)
    }
}
