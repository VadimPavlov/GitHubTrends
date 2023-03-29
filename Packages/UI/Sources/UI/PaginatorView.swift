//
//  PaginatorView.swift
//  
//
//  Created by Vadym Pavlov on 29.03.2023.
//

import SwiftUI
import Utilities

public struct PaginationView<C: View, I: Identifiable>: View {
    
    @ObservedObject var paginator: Paginator<I>
    let spacing: CGFloat?
    let content: (I) -> C
    
    public init(paginator: Paginator<I>, spacing: CGFloat? = nil, @ViewBuilder content: @escaping (I) -> C) {
        _paginator = .init(initialValue: paginator)
        self.spacing = spacing
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: spacing) {
                ForEach(paginator.items) { item in
                    content(item)
                }
                if let error = paginator.error {
                    VStack {
                        Text("Error").bold()
                        Text(error).multilineTextAlignment(.center)
                        Button(action: { paginator.reload() }) {
                            Image(systemName: "arrow.clockwise").font(.headline)
                        }.padding(.top)
                    }
                    .padding()
                    .foregroundColor(.red)
                } else if paginator.canLoadMore {
                    ProgressView().onAppear {
                        paginator.loadMore()
                    }
                    .padding(.vertical)
                }
            }
            .padding(.vertical)
        }
    }
}
