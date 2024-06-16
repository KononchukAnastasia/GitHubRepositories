//
//  RepositoryDetailsView.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 10.06.2024.
//

import SwiftUI
import MarkdownUI

struct RepositoryDetailsView: View {
    // MARK: - Property Wrappers
    
    @StateObject private var repositoryDetailsViewModel =
        RepositoryDetailsViewModel()
    
    @Binding var user: User?
    
    // MARK: - Public Properties
    
    let repository: Repository
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    InfoView(repository: repository)
                        .padding([.horizontal, .top])
                    
                    if repositoryDetailsViewModel.isLoading {
                        LoaderView(color: .white, size: 40)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = repositoryDetailsViewModel.error {
                        VStack(spacing: 24) {
                            Text(error)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                            
                            if !repositoryDetailsViewModel.isReadmeNotFound {
                                ButtonView(text: "Retry") { getContent() }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                    } else {
                        ScrollView {
                            if let markdownText = repositoryDetailsViewModel.markdownText {
                                markdown(text: markdownText)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle(repository.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Log out") {
                        user = nil
                    }
                    .foregroundStyle(.white)
                }
            }
            .onAppear {
                getContent()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getContent() {
        repositoryDetailsViewModel.getContent(
            owner: repository.owner.login,
            repo: repository.name,
            path: "README.md"
        )
    }
}

// MARK: - Extension RepositoryDetailsView

extension RepositoryDetailsView {
    @ViewBuilder
    private func markdown(text: String) -> some View {
        let url = URL(
            string: repositoryDetailsViewModel.content?.downloadUrl ?? ""
        )
        
        Markdown(text, baseURL: url)
            .markdownTextStyle() {
                ForegroundColor(.white)
            }
    }
}

// MARK: - Preview

#Preview {
    RepositoryDetailsView(
        user: .constant(User.getUser()),
        repository: Repository.getRepository()
    )
}
