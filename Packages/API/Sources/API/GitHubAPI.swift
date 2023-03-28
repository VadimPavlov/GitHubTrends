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
    public let decoder: JSONDecoder
    static let shortDF = DateFormatter(dateFormat: "yyyy-MM-dd")
    
    public init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    struct Link {
        let next: String
        let last: String
    }
    
    func link(from response: HTTPURLResponse?) -> Link? {
        
        func rel(_ value: String) -> String {
            "(?<=<).+?(?=>; rel=\"\(value)\")"
        }
        
        if let link = response?.allHeaderFields["Link"] as? String,
           let next = try? link.regex(pattern: rel("next")).first,
           let last = try? link.regex(pattern: rel("last")).first {
            return Link(next: next, last: last)
        }
        return nil
    }
}

public extension GitHubAPI {
    
    // MARK: - Search
    enum Comparison: String {
        case less = "<"
        case greater = ">"
        case equal = "="
    }
        
    enum SearchQuery {
        case created(Comparison, Date)
        
        var value: String {
            switch self {
            case .created(let condition, let date):
                return "created:\(condition.rawValue)" + GitHubAPI.shortDF.string(from: date)
            }
        }
    }
    
    enum SearchSort: String {
        case stars
    }
    
    enum SearchOrder: String {
        case asc
        case desc
    }
    
    func searchRepositories(query: [SearchQuery], sort: SearchSort, order: SearchOrder) async throws -> GHSearchResult<GHRepository> {
        let query = query.map { $0.value }.joined(separator: "+")
        let request = try self.request(with: "search/repositories",
                                       params: ["q": query, "sort": sort.rawValue, "order": order.rawValue])
        let (data, response) = try await self.response(for: request)
        let link = self.link(from: response)
        let result = try decoder.decode(GHSearchResult<GHRepository>.self, from: data)
        return result
    }

}
