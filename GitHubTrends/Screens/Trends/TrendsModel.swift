//
//  TrendsModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API
import SwiftUI
import Utilities

enum ValidationError: LocalizedError {
    case message(String)
    
    var errorDescription: String? {
        switch self {
        case .message(let message):
            return message
        }
    }
}

final class TrendsModel: ObservableObject {
    
    enum Destination {
        case detail(RepositoryDetailModel)
    }
    
    enum Timeline: String, Identifiable, CaseIterable {
        case day
        case week
        case month
        
        var id: String { rawValue }
        var title: String { rawValue.capitalized } // TODO: use (localized) strings
    }

    @Injected var api: GitHubAPI
    @Published var destination: Destination?
    @AppStorage("timeline") var timeline: Timeline = .day {
        didSet { reloadRepositories() }
    }
        
    lazy var repositories = Paginator<GHRepository>(page: 1, size: 30) { [unowned self] page in
        let response: GitHubAPI.SearchRepositoriesResult
        if let next = self.nextRepositories {
            response = try await self.api.linked(request: URLRequest(url: next))
        } else if page.index == 1 {
            let date = try self.date(from: timeline)
            response = try await self.api.searchRepositories(query: [.created(.greater, date)],
                                                            sort: .stars, order: .desc)
        } else {
            // we reached the last page, there is no link to a next page
            return []
        }
        self.nextRepositories = response.link?.last
        return response.result.items
    }
    
    private let calendar = Calendar(identifier: .iso8601)
    private var nextRepositories: URL?

    init(destination: Destination? = nil, repositories: [GHRepository] = []) {
        self.destination = destination
        self.repositories.items = repositories
    }
    
    func select(repository: GHRepository) {
        self.destination = .detail(RepositoryDetailModel(repository: repository))
    }
    
    func date(from timeline: Timeline) throws -> Date {
        let date: Date?
        switch timeline {
        case .day: date = calendar.dayAgo()
        case .week: date = calendar.weekAgo()
        case .month: date = calendar.monthAgo()
        }
        
        guard let date = date else { throw ValidationError.message("Can't calculate a date") }
        return date
    }
    
    func reloadRepositories() {
        nextRepositories = nil
        repositories.clear()
        repositories.loadFirst()
    }
}
