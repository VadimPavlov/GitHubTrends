//
//  GitHubTrendsApp.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI
import API

@main
struct GitHubTrendsApp: App {
    @StateObject var model = AppModel()
    
    var body: some Scene {
        WindowGroup {
            AppScreen(model: model)
        }
    }
}
