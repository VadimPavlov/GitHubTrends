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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    timelineView
                }
            }
            .sheet(unwrapping: $model.destination, case: /TrendsModel.Destination.detail) { $model in
                RepositoryDetailScreen(model: model)
            }
        }
    }
    
    // MARK: Views
    
    var listView: some View {
        ScrollView {
            LazyVStack {
                ForEach(model.repositories) { repo in
                    Button {
                        model.select(repository: repo)
                    } label: {
                        RepositoryCell(repository: repo)
                    }
                }
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
