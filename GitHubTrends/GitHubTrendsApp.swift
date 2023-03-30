//
//  GitHubTrendsApp.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import Utilities
import API
import Database

@main
struct GitHubTrendsApp: App {
    @StateObject var model = AppModel()
    let database = Database()
    let resolver = Resolver.shared
    init() {
        resolver.register(GitHubAPI())
        resolver.register(database)
    }
    
    var body: some Scene {
        WindowGroup {
            AppScreen(model: model)
                .environment(\.managedObjectContext, database.mainContext)
        }
    }
}
