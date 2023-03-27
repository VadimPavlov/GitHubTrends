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
            Text("Repository Detail Screen")
                .navigationTitle(model.repository.name)
                .toolbar {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
        }
    }
}

struct RepositoryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailScreen(model: .init(repository: GHRepository.mocks[0]))
    }
}
