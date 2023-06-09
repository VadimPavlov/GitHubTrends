//
//  TrendsScreen.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import UI
import API
import SwiftUI
import SwiftUINavigation

struct TrendsScreen: View {
    
    @ObservedObject var model: TrendsModel
    
    var body: some View {
        NavigationView {
            listView
            .navigationTitle("Trends")
            .searchable(text: $model.searchText)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    timelineView
                }
            }
            .background {
                // a workaround to avoid multiple NavigationLinks in ForEach
                // https://github.com/pointfreeco/swiftui-navigation/discussions/2
                NavigationLink(unwrapping: $model.destination,
                               case: /TrendsModel.Destination.detail) { _ in
                } destination: { $model in
                    RepositoryDetailScreen(model: model)
                } label: {
                    EmptyView()
                }
            }
        }
    }
    
    // MARK: Views
    var listView: some View {
        PaginationView(paginator: model.repositories) { repo in
            Button {
                model.select(repository: repo)
            } label: {
                RepositoryCell(repository: repo)
            }
        }
    }
        
    var timelineView: some View {
        Picker(selection: $model.timeline) {
            ForEach(TrendsModel.Timeline.allCases) { timeline in
                Text(timeline.title).tag(timeline)
            }
        } label: {
            EmptyView()
        }
        .pickerStyle(.segmented)
    }
}


struct TrendsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TrendsScreen(model: .init(repositories: GHRepository.mocks))
    }
}
