//
//  RepositoryDetailModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API

final class RepositoryDetailModel: ObservableObject {
    
    enum Destination {}
    @Published var destination: Destination?
    @Published var repository: GHRepository
    
    init(destination: Destination? = nil, repository: GHRepository) {
        self.destination = destination
        self.repository = repository
    }
}
