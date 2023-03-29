import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}

public protocol API {
    var baseURL: String { get }
    var session: URLSession { get }
    var decoder: JSONDecoder { get }

    func userInfo(from response: HTTPURLResponse?, data: Data) -> [String: String]

}

public extension API {
    
    func userInfo(from response: HTTPURLResponse?, data: Data) -> [String: String] {
        [NSLocalizedDescriptionKey: response?.url?.path ?? ""]
    }

    func request(with path: String, method: HTTPMethod = .get, params: [String: String?] = [:]) throws -> URLRequest {
        var components = URLComponents(string: baseURL)
        components?.path += path
        
        var httpBody: Data?
        switch method {
        case .get:
            components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        default:
            httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        guard let url = components?.url else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = httpBody
        return request
    }
    
    typealias DataResponse = (Data, HTTPURLResponse?)
    func response(for request: URLRequest) async throws -> DataResponse {
        let (data, response) = try await session.data(for: request)
        let httpResponse = response as? HTTPURLResponse
        
        let code = httpResponse?.statusCode ?? 0
        let userInfo = { self.userInfo(from: httpResponse, data: data) }

        switch code {
        case 200..<300: break
            // 3xx redirections
        case 300..<400: throw URLError(.httpTooManyRedirects, userInfo: userInfo())
            // 4xx client errors
        case 400: throw URLError(.badURL, userInfo: userInfo())
        case 401: throw URLError(.userAuthenticationRequired, userInfo: userInfo())
        case 400..<500: throw URLError(.resourceUnavailable, userInfo: userInfo())
        default:
            // 5xx server errors
            throw URLError(.badServerResponse, userInfo: userInfo())
        }
         
        return (data, httpResponse)
    }
    
    func fetch<D: Decodable>(request: URLRequest) async throws -> D {
        let (data, _) = try await response(for: request)
        return try decoder.decode(D.self, from: data)
    }
}
