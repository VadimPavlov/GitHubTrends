//
//  GitHubAPI.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation
import Utilities

public struct Linked<D: Decodable> {
    public let result: D
    public let link: GHLink?
}

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
        
    func link(from response: HTTPURLResponse?) -> GHLink? {
        guard let link = response?.allHeaderFields["Link"] as? String else { return nil }
        
        func url(_ rel: String) -> URL? {
            let pattern = "[^<>]+(?=>; rel=\"\(rel)\")"
            let value = try? link.regex(pattern: pattern).first
            return value.flatMap { URL(string: $0) }
        }
        
        return GHLink(next: url("next"), prev: url("prev"), first: url("first"), last: url("last"))
    }
    
    public func errorUserInfo(from response: HTTPURLResponse?, data: Data) -> [String : String] {
        let error = try? decoder.decode(GHError.self, from: data)
        let path = response?.url?.path ?? ""
        return [NSLocalizedDescriptionKey: error?.message ?? path]
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
    
    typealias SearchRepositoriesResult = Linked<GHSearchResult<GHRepository>>
    func searchRepositories(query: [SearchQuery], sort: SearchSort, order: SearchOrder) async throws -> SearchRepositoriesResult {
        let query = query.map { $0.value }.joined(separator: "+")
        let request = try self.request(with: "search/repositories",
                                       params: ["q": query, "sort": sort.rawValue, "order": order.rawValue])
        return try await linked(request: request)
    }

    func linked<D: Decodable>(request: URLRequest) async throws -> Linked<D> {
        let (data, response) = try await self.response(for: request)
        let link = self.link(from: response)
        let result = try decoder.decode(D.self, from: data)
        return Linked(result: result, link: link)
    }
}
