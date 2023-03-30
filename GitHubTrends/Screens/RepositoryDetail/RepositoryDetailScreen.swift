//
//  RepositoryDetailScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import API
import SwiftUINavigation

struct RepositoryDetailScreen: View {
    
    @ObservedObject var model: RepositoryDetailModel
    
    var body: some View {
            ScrollView {
                VStack {
                    if let name = model.repository.name {
                        Text(name).font(.largeTitle)//.bold()
                    }
                    Group {
                        headerView
                        Text(model.repository.decsription2)
                    }.padding()
                }
            }
            .alert(unwrapping: $model.destination, case: /RepositoryDetailModel.Destination.alert) {
                _ in
            }
            .toolbar {
                if let url = model.repository.htmlUrl {
                    Link(destination: url) {
                        Image(systemName: "safari")
                    }
                }
                favoriteButton
            }
    }
    
    @ViewBuilder
    var headerView: some View {
        VStack {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    if let created = model.created {
                        Text("Created: \(created)")
                    }
                    if let language = model.repository.language {
                        Text("Language: \(language)")
                    }
                }
                .monospaced()
                Spacer()
                
                Group {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("\(model.repository.stars)")
                    }
                    VStack {
                        Image(systemName: "arrow.triangle.branch")
                        Text("\(model.repository.forks)")
                    }
                }.font(.headline)
            }
        }
    }
    
    var favoriteButton: some View {
        Button(action: {
            withAnimation { model.toogleFavorite() }
        }) {
            if let isFavorite = model.isFavorite {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            }
        }
    }
}

struct RepositoryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailScreen(model: .init(repository: GHRepository.mocks[0]))
    }
}
