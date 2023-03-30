//
//  RepositoryDetailModel.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API
import Database
import Utilities
import SwiftUINavigation

final class RepositoryDetailModel: ObservableObject {
        
    enum Destination {
        case alert(AlertError)
    }
    
    @Published var destination: Destination?
    @Published var repository: Repository
    @Published var isFavorite: Bool?
    let created: String?
    
    @Injected var db: Database
    
    let favoritesChange = NSNotification.Name("FavoritesChange")
    var favoritesToken: NSObjectProtocol?
    
    init(destination: Destination? = nil, repository: Repository, isFavorite: Bool? = nil) {
        self.destination = destination
        self.repository = repository
        self.isFavorite = isFavorite
        self.created = repository.created?.formatted(date: .numeric, time: .omitted)

        self.subscribeToNotifications()
        // fetch flag if not provided
        if isFavorite == nil {
            self.fetchFavorite()
        }
    }
        
    // MARK: - Actions
    func toogleFavorite() {
        guard let isFavorite = isFavorite else { return }
        Task { @MainActor in
            do {
                if isFavorite {
                    try await db.removeFromFavorites(repository: repository)
                } else {
                    try await db.addToFavorites(repository: repository)
                }
                NotificationCenter.default.post(name: favoritesChange, object: repository)
            } catch {
                destination = .alert(AlertError(error: error))
            }
        }
    }
    
}

private extension RepositoryDetailModel {
    func fetchFavorite() {
        Task { @MainActor in
            do {
                isFavorite = try await db.isFavorite(repository: repository)
            } catch {
                destination = .alert(AlertError(error: error))
            }
        }
    }
    
    func subscribeToNotifications() {
        // listen for changes from other RepositoryDetailModel screens
        favoritesToken = NotificationCenter.default.addObserver(forName: favoritesChange, object: nil, queue: nil) { [weak self] notification in
            if let repo = notification.object as? Repository {
                if self?.repository.id == repo.id {
                    self?.isFavorite?.toggle()
                }
            }
        }
    }
}
