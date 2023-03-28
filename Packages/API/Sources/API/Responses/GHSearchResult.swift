//
//  GHSearchResult.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import Foundation

public struct GHSearchResult<Item: Decodable>: Decodable {
    public let totalCount: Int
    public let items: [Item]
}
