//
//  Mocks.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import Foundation
import API

extension GHOwner {
    static let mock = Self(id: 1, login: "MockOwner", avatarUrl: nil)
    static let vadim = Self(id: 2, login: "VadimPavlov", avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/11664859?")!)
}

extension GHRepository {
    static let mocks: [Self] = [
        .init(id: 1, name: "GitHubTrends", description: "iOS Application as technical task", createdAt: Date(),
              htmlUrl: URL(string: "https://github.com/VadimPavlov/GitHubTrends")!, owner: .vadim, stargazersCount: 123, language: "Swift", forks: 10),
        .init(id: 2, name: "CreateDesktop", description: "Example application for creating multiple desktops on Windows", createdAt: .init(timeIntervalSinceReferenceDate: 0), htmlUrl: URL(string: "https://github.com/MalwareTech/CreateDesktop")!, owner: .mock, stargazersCount: 321, forks: 999)
    ]
}
