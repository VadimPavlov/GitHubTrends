//
//  FavoritesModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import Database
import CoreData

final class FavoritesModel: ObservableObject {
    
    enum Destination {
        case detail(RepositoryDetailModel)
    }
    
    @Published var destination: Destination?
    @Published var searchText = ""
        
    init(destination: Destination? = nil) {
        self.destination = destination
    }

    func select(repository: CDRepository) {
        self.destination = .detail(RepositoryDetailModel(repository: repository, isFavorite: true))
    }
    
    var searchPredicate: NSPredicate? {
        searchText.isEmpty ? nil : CDRepository.searchPredicate(text: searchText)
    }
}
