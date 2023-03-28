//
//  AlertError.swift
//  GitHubTrends
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation
import SwiftUINavigation

enum AlertErrorActions {
    case ok
}

typealias AlertError = AlertState<AlertErrorActions>

extension AlertState {
    init(error: Error) {
        self.init {
            TextState("Error")
        } actions: {
            ButtonState {
                TextState("Ok")
            }
        } message: {
            TextState(error.localizedDescription)
        }
    }
}
