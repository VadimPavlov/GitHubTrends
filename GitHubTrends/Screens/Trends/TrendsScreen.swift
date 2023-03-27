//
//  TrendsScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import API

struct TrendsScreen: View {
    @ObservedObject var model: TrendsModel
    
    var body: some View {
        NavigationView {
            NavigationLink("Details Screen", destination: RepositoryDetailScreen(model: .init(repository: GHRepository(id: 0)))).navigationTitle("Trends")
        }
    }
}

struct TrendsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrendsScreen(model: .init())
    }
}
