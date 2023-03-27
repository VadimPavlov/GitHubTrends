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
        Text("Repository Detail Screen")
            .navigationTitle(Text("Respository: \(model.repository.id)"))
    }
}

struct RepositoryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailScreen(model: .init(repository: GHRepository(id: 0)))
    }
}
