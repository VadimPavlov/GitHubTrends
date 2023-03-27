//
//  TrendsModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API
import SwiftUI

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
    
    @Published var destination: Destination?
    @Published var repositories: [GHRepository]
    @AppStorage("timeline") var timeline: Timeline = .day
    
    init(destination: Destination? = nil, repositories: [GHRepository] = []) {
        self.destination = destination
        self.repositories = repositories
    }
    
    func select(repository: GHRepository) {
        self.destination = .detail(RepositoryDetailModel(repository: repository))
    }
}
