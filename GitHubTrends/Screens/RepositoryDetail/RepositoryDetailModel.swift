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
    @Published var isFavorite: Bool
    let created: String
    
    init(destination: Destination? = nil, repository: GHRepository, isFavorite: Bool = false) {
        self.destination = destination
        self.repository = repository
        self.isFavorite = isFavorite
        self.created = repository.createdAt.formatted(date: .abbreviated, time: .omitted)
    }
    
    // MARK: - Actions
    
    func toogleFavorite() {
        isFavorite.toggle()
        // TODO: save changes
    }
}
