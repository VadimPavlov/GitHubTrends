//
//  AppScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI

struct AppScreen: View {
    
    @ObservedObject var model: AppModel
    
    var body: some View {
        TabView(selection: $model.destination) {
            TrendsScreen(model: model.trendsModel)
                .tabItem { Label("Trends", systemImage: "flame") }
                .tag(AppModel.Destination.trends)
            
            FavoritesScreen(model: model.favoritesModel)
                .tabItem { Label("Favorites", systemImage: "heart")}
                .tag(AppModel.Destination.favorites)
        }
        //.navigationViewStyle(.stack)
    }
}

struct AppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppScreen(model: .init())
    }
}
