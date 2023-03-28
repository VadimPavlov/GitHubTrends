//
//  ResuableUI.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//
import UI
import API
import SwiftUI

extension RepositoryCell {
    init(repository: GHRepository) {
        self.init(title: repository.name, author: repository.owner.login,
                  description: repository.fullDescription, stars: repository.stargazersCount)
    }
}
