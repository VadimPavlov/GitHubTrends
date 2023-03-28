//
//  RepositoryCell.swift
//  
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI

public struct RepositoryCell: View {
    public init(title: String, author: String, avatar: URL?, description: String, stars: Int) {
        self.title = title
        self.author = author
        self.avatar = avatar
        self.description = description
        self.stars = stars
    }
    
    let title: String
    let author: String
    let avatar: URL?
    let description: String
    let stars: Int
    
    public var body: some View {
        HStack(alignment: .top) {
            VStack {
                AvatarView(url: avatar)
                Image(systemName: "star.fill")
                Text("\(stars)")
            }.font(.headline)

            VStack(alignment: .leading) {
                Text("@" + author)
                Text(title).font(.headline)
                Text(description)
                    .italic()
                    .lineLimit(2)
                    .padding(.top, 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .multilineTextAlignment(.leading)
        }.padding()
    }
}

struct RepositoryCell_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCell(title: "Repository name title", author: "Author", avatar: nil, description: "Somewhat long description for the repository", stars: 123)
    }
}
