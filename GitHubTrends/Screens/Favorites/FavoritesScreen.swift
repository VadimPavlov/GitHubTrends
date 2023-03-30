//
//  FavoritesScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import API
import Database
import UI
import SwiftUINavigation

struct FavoritesScreen: View {
        
    @ObservedObject var model: FavoritesModel
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.intStars, order: .reverse)])
    private var repositories: FetchedResults<CDRepository>
    
    var body: some View {
        NavigationView {
            listView
            .navigationTitle("Favorites")
            .searchable(text: $model.searchText)
            .background {
                // a workaround to avoid multiple NavigationLinks in ForEach
                // https://github.com/pointfreeco/swiftui-navigation/discussions/2
                NavigationLink(unwrapping: $model.destination,
                               case: /FavoritesModel.Destination.detail) { _ in
                } destination: { $model in
                    RepositoryDetailScreen(model: model)
                } label: {
                    EmptyView()
                }
            }
        }.onChange(of: model.searchText) { _ in
            repositories.nsPredicate = model.searchPredicate
        }
    }
    
    @ViewBuilder
    var listView: some View {
        if repositories.isEmpty {
            Text(model.searchText.isEmpty ? "No repositories yet": "No repositories found")
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(repositories) { repo in
                        Button {
                            model.select(repository: repo)
                        } label: {
                            RepositoryCell(repository: repo)
                        }
                    }
                }
            }
        }
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen(model: .init())
    }
}
