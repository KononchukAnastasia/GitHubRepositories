//
//  RepositoriesView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 08.06.2024.
//

import SwiftUI

struct RepositoriesView: View {
    @StateObject private var repositoriesViewModel = RepositoriesViewModel()
    
    let user: User
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.black
                    .ignoresSafeArea()
                
                if repositoriesViewModel.isLoading {
                    LoaderView(color: .white, size: 40)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = repositoriesViewModel.error {
                    VStack(spacing: 24) {
                        Text(error)
                            .multilineTextAlignment(.center)
                        
                        ButtonView(text: "Retry") {
                            fetchRepos()
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    LazyVStack {
                        ForEach(
                            repositoriesViewModel.repositories,
                            id: \.self
                        ) { repository in
                            RepositoryRowView(
                                title: repository.name,
                                info: repository.description ?? "",
                                language: repository.language ?? ""
                            )
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Repositories")
            .toolbar {
                Button("Log out") {
                    // TODO: implement later
                }
                .foregroundStyle(.white)
                .onAppear {
                    fetchRepos()
                }
            }
        }
    }
    
    private func fetchRepos() {
        repositoriesViewModel.fetchRepos(url: user.reposUrl)
    }
}

#Preview {
    RepositoriesView(user: User.getUser())
}
