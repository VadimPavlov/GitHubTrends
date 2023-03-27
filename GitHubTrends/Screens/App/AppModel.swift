//
//  AppModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation

final class AppModel: ObservableObject {
    
    enum Destination {
        case trends
        case favorites
    }
    
    @Published var destination: Destination
    @Published var trendsModel: TrendsModel
    @Published var favoritesModel: FavoritesModel
    
    init(destination: Destination = .trends,
         trendsModel: TrendsModel = .init(),
         favoritesModel: FavoritesModel = .init()) {
        self.destination = destination
        self.trendsModel = trendsModel
        self.favoritesModel = favoritesModel
    }
}
