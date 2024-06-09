//
//  RepositoryRowView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 08.06.2024.
//

import SwiftUI

struct RepositoryRowView: View {
    let title: String
    let info: String?
    let language: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .foregroundStyle(.blue)
                    .lineLimit(1)
                    .font(.title3)
                
                Spacer()
                
                Text(language ?? "")
                    .foregroundStyle(.red)
                    .font(.subheadline)
            }
            
            Text(info ?? "")
                .foregroundStyle(.white)
                .lineLimit(4)
                .font(.callout)
            
            Divider()
                .background(.asphalt)
        }
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        RepositoryRowView(
            title: "Repositories",
            info: "SwiftUI drawing",
            language: "Swift"
        )
    }
    
}
