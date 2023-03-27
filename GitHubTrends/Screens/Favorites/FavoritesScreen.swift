//
//  FavoritesScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import API

struct FavoritesScreen: View {
        
    @ObservedObject var model: FavoritesModel
    
    var body: some View {
        NavigationView {
            NavigationLink("Details Screen", destination: RepositoryDetailScreen(model: .init(repository: GHRepository(id: 1)))).navigationTitle("Favorites")
        }
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen(model: .init())
    }
}
