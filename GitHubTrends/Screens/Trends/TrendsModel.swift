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
    
    @Published var destination: Destination?
    @Published var repositories: [GHRepository]
    @AppStorage("timeline") var timeline: Timeline = .day {
        didSet { loadRepositories() }
    }
    
    let api = GitHubAPI()
    
    init(destination: Destination? = nil, repositories: [GHRepository] = []) {
        self.destination = destination
        self.repositories = repositories
        self.loadRepositories()
    }
    
    func select(repository: GHRepository) {
        self.destination = .detail(RepositoryDetailModel(repository: repository))
    }
    
    func loadRepositories() {
        Task { @MainActor in
            do {
                if let date = date(from: timeline) {
                    let response = try await self.api.searchRepositories(query: [.created(.greater, date)], sort: .stars, order: .desc)
                    self.repositories = response.items
                } else {
                    let error = AlertError(title: {
                        TextState("Error")
                    }, message: {
                        TextState("Can't calcualte a date")
                    })
                    self.destination = .alert(error)
                }
            } catch {
                self.destination = .alert(AlertError(error: error))
            }
        }
    }
    
    func date(from timeline: Timeline) -> Date? {
        let calendar = Calendar(identifier: .iso8601)
        switch timeline {
        case .day: return calendar.dayAgo()
        case .week: return calendar.weekAgo()
        case .month: return calendar.monthAgo()
        }
    }
}
