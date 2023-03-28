//
//  AvatarView.swift
//  
//
//  Created by Vadym Pavlov on 28.03.2023.
//

import SwiftUI

public struct AvatarView: View {
    public init(url: URL?) {
        self.url = url
    }
    
    let url: URL?
    public var body: some View {
        CachedAsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .resizable()
        }
        .frame(width: 50, height: 50)
        .mask(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(url: URL(string: "https://avatars..com/u/11664859?")!)
    }
}

