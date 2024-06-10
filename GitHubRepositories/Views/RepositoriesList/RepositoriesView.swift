//
//  RepositoriesView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 08.06.2024.
//

import SwiftUI

struct RepositoriesView: View {
    @StateObject private var repositoriesViewModel = RepositoriesViewModel()
    
    @Binding var user: User?
    
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
                            .foregroundStyle(.white)
                        
                        ButtonView(text: "Retry") { fetchRepos() }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(
                                repositoriesViewModel.repositories,
                                id: \.self
                            ) { repository in
                                RepositoryRowView(
                                    title: repository.name,
                                    info: repository.description,
                                    language: repository.language
                                )
                                .padding(.horizontal)
                                .onAppear {
                                    guard let user = user else { return }
                                    
                                    repositoriesViewModel.onScrolledAtBottom(
                                        url: user.reposUrl,
                                        repository: repository
                                    )
                                }
                            }
                            
                            if repositoriesViewModel.isShowLoader() {
                                LoaderView(color: .white, size: 30)
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Repositories")
            .toolbar {
                Button("Log out") {
                    user = nil
                }
                .foregroundStyle(.white)
                .onAppear {
                    fetchRepos()
                }
            }
        }
    }
    
    private func fetchRepos() {
        guard let user = user else { return }
        repositoriesViewModel.fetchRepos(url: user.reposUrl)
    }
}

#Preview {
    RepositoriesView(user: .constant(User.getUser()))
}
