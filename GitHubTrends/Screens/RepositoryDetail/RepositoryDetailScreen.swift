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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Group {
                        headerView
                        Text(model.repository.description)
                        footerView

                    }.padding()
                }
            }
            .navigationTitle(model.repository.name)
            .toolbar {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                }
            }
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
    
    var footerView: some View {
        HStack {
            Link(destination: model.repository.htmlUrl) {
                Image(systemName: "safari")
            }
            Rectangle().fill(Color.accentColor).frame(width: 1, height: 20)
            Button(action: {
                withAnimation {
                    model.toogleFavorite()
                }
            }) {
                Image(systemName: model.isFavorite ? "heart.fill" : "heart")
            }
        }.font(.title)
    }
}

struct RepositoryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailScreen(model: .init(repository: GHRepository.mocks[0]))
    }
}
