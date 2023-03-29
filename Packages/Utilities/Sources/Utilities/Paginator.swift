//
//  Paginator.swift
//  
//
//  Created by Vadym Pavlov on 29.03.2023.
//

import Foundation

public struct Page {
    public let index: Int
    public let size: Int
}

public class Paginator<I>: ObservableObject {
    
    @Published public var items: [I] = []
    @Published public var canLoadMore = true
    @Published public var error: String?
    
    @Published public private(set) var isLoading = false
    @Published public private(set) var page: Int
    private let initialPage: Int
    private var loadTask: Task<Void, Never>?
    
    public typealias LoadPage = (Page) async throws -> [I]
    let load: LoadPage
    let size: Int
        
    public init(page: Int = 0, size: Int, load: @escaping LoadPage) {
        self.initialPage = page
        self.page = page
        self.size = size
        self.load = load
        self.loadFirst()
    }
    
    public func clear() {
        canLoadMore = true
        isLoading = false
        loadTask?.cancel()
        page = initialPage
        items = []
    }
    
    public func loadFirst() {
        self.load(page: initialPage)
    }
    
    public func loadMore() {
        self.load(page: page + 1)
    }
    
    public func reload() {
        self.load(page: page)
    }
    
    func load(page: Int) {
        if isLoading || !canLoadMore { return }
        error = nil
        isLoading = true
        let size = self.size
        loadTask = Task { @MainActor in
            do {
                let items = try await self.load(.init(index: page, size: size))
                guard !Task.isCancelled else { return }
                self.canLoadMore = items.count == size
                self.page = page
                self.items += items
                self.isLoading = false
            } catch {
                self.isLoading = false
                if !error.isCancelled {
                    self.error = error.localizedDescription
                }
            }
        }
    }
}
