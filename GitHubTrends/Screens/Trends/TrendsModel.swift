//
//  TrendsModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API

final class TrendsModel: ObservableObject {
    
    enum Destination {
        case detail(RepositoryDetailModel)
    }
    
    @Published var destination: Destination?
    @Published var repositories: [GHRepository]
    
    init(destination: Destination? = nil, repositories: [GHRepository] = []) {
        self.destination = destination
        self.repositories = repositories
    }
    
    func select(repository: GHRepository) {
        self.destination = .detail(RepositoryDetailModel(repository: repository))
    }
}
