//
//  RepositoryDetailScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import API

struct RepositoryDetailScreen: View {
    
    @ObservedObject var model: RepositoryDetailModel
    
    var body: some View {
            ScrollView {
                VStack {
                    Group {
                        headerView
                        Text(model.repository.description)

                    }.padding()
                }
            }
            .navigationTitle(model.repository.name)
            .toolbar {
                    Link(destination: model.repository.htmlUrl) {
                        Image(systemName: "safari")
                    }
                    favoriteButton
            }
    }
    
    @ViewBuilder
    var headerView: some View {
        VStack {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Created: \(model.created)")
                    if let language = model.repository.language {
                        Text("Language: \(language)")
                    }
                }
                .monospaced()
                Spacer()
                
                Group {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("\(model.repository.stargazersCount)")
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
            Image(systemName: model.isFavorite ? "heart.fill" : "heart")
        }
    }
}

struct RepositoryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailScreen(model: .init(repository: GHRepository.mocks[0]))
    }
}
