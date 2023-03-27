//
//  GitHubTrendsApp.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI

@main
struct GitHubTrendsApp: App {
    @StateObject var model = AppModel()
    
    var body: some Scene {
        WindowGroup {
            AppScreen(model: model)
        }
    }
}
