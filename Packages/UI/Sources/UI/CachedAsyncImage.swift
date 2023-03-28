//
//  CachedAsyncImage.swift
//  
//
//  Created by Vadym Pavlov on 29.03.2023.
//

import SwiftUI

public struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    
    let cache: URLCache
    let session: URLSession
    
    let request: URLRequest?
    
    let content: (Image) -> Content
    let placeholder: () -> Placeholder
    
    @State var data: Data?
    
    public init(url: URL?, cache: URLCache = .shared, session: URLSession = .shared,
                @ViewBuilder content: @escaping (Image) -> Content,
                @ViewBuilder placeholder: @escaping () -> Placeholder) {
        self.request = url.map { URLRequest(url: $0) }
        self.cache = cache
        self.session = session
        self.content = content
        self.placeholder = placeholder
    }
    
    public var body: some View {
        ZStack {
            if let data = data, let image = UIImage(data: data) {
                content(Image(uiImage: image))
            } else {
                placeholder()
            }
        }.task {
            await self.load()
        }
    }
    
    
    func load() async {
        do {
            guard let request = request else { return }
            if let cached = cache.cachedResponse(for: request)?.data {
                self.data = cached
            } else {
                let (data, response) = try await session.data(for: request)
                let cached = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cached, for: request)
                self.data = data
            }
        } catch {
            // TODO: cover an AsyncIamgePhase with .failure case
            print(error)
        }
    }

}
