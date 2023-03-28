//
//  TrendsModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API
import SwiftUI
import SwiftUINavigation
import Utilities

final class TrendsModel: ObservableObject {
    
    enum Destination {
        case detail(RepositoryDetailModel)
        case alert(AlertError)
    }
    
    enum Timeline: String, Identifiable, CaseIterable {
        case day
        case week
        case month
        
        var id: String { rawValue }
        var title: String { rawValue.capitalized } // TODO: use (localized) strings
    }

    let repositories: Job<[GHRepository]>
    @Published var destination: Destination?
    @AppStorage("timeline") var timeline: Timeline = .day {
        didSet { repositories.reload() }
    }
    
    let api = GitHubAPI() // TODO: dependency injection
    
    init(destination: Destination? = nil, repositories: [GHRepository]? = nil) {
        self.destination = destination
        self.repositories = Job(result: repositories)
        
        self.repositories.work = { [unowned self] in
            let date = self.date(from: timeline)
            let response = try await self.api.searchRepositories(query: [.created(.greater, date)],
                                        sort: .stars, order: .desc)
            return response.items
        }
        
        self.repositories.run()
    }
    
    func select(repository: GHRepository) {
        self.destination = .detail(RepositoryDetailModel(repository: repository))
    }
    
    func date(from timeline: Timeline) -> Date {
        let calendar = Calendar(identifier: .iso8601)
        switch timeline {
        case .day: return calendar.dayAgo()!
        case .week: return calendar.weekAgo()!
        case .month: return calendar.monthAgo()!
        }
    }
}
