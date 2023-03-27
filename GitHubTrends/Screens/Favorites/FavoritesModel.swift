//
//  FavoritesModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation

final class FavoritesModel: ObservableObject {
    
    enum Destination {
        case detail(RepositoryDetailModel)
    }
    
    var destination: Destination?
    
    init(destination: Destination? = nil) {
        self.destination = destination
    }

}
