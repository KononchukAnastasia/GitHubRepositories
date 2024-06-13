//
//  InfoView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 10.06.2024.
//

import SwiftUI

struct InfoView: View {
    let repository: Repository
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image("link")
                
                if let url = URL(string: repository.htmlURL) {
                    Link(repository.htmlURL, destination: url)
                        .font(.footnote)
                        .foregroundStyle(.sky)
                }
            }
            
            HStack {
                Image("star")
                
                Text("0")
                    .foregroundStyle(.golden)
                
                Text("stars")
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image("fork")
                
                Text("0")
                    .foregroundStyle(.grass)
                
                Text("fork")
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image("watcher")
                
                Text("0")
                    .foregroundStyle(.arctic)
                
                Text("watcher")
                    .foregroundStyle(.white)
            }
        }
        
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        InfoView(repository: Repository.getRepository())
    }
}
