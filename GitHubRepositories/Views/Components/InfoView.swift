//
//  InfoView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 10.06.2024.
//

import SwiftUI

struct InfoView: View {
    // MARK: - Public Properties
    
    let repository: Repository
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image("link")
                
                if let url = URL(string: repository.htmlURL) {
                    Link(linkTitle(text: repository.htmlURL), destination: url)
                        .font(.footnote)
                        .foregroundStyle(.sky)
                }
            }
            
            HStack {
                Image("star")
                
                Text("\(repository.stargazersCount)")
                    .foregroundStyle(.golden)
                
                Text("stars")
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image("fork")
                
                Text("\(repository.forksCount)")
                    .foregroundStyle(.grass)
                
                Text("fork")
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image("watcher")
                
                Text("\(repository.watchersCount)")
                    .foregroundStyle(.arctic)
                
                Text("watcher")
                    .foregroundStyle(.white)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func linkTitle(text: String) -> String {
        text.replacingOccurrences(of: "https://", with: "")
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        
        InfoView(repository: Repository.getRepository())
    }
}
