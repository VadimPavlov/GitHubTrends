//
//  RepositoryCell.swift
//  
//
//  Created by Vadym Pavlov on 27.03.2023.
//

import SwiftUI

public struct RepositoryCell: View {
    public init(title: String, author: String, description: String, stars: Int) {
        self.title = title
        self.author = author
        self.description = description
        self.stars = stars
    }
    
    let title: String
    let author: String
    let description: String
    let stars: Int
    
    public var body: some View {
        HStack(alignment: .top) {
            Circle().fill().frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text("@" + author)
                Text(title).font(.headline)
                Text(description)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            VStack {
                Image(systemName: "star.fill")
                Text("\(stars)")
            }.font(.headline)
        }.padding()
    }
}

struct RepositoryCell_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryCell(title: "Repository name title", author: "Author", description: "Somewhat long description for the repository", stars: 123)
    }
}
