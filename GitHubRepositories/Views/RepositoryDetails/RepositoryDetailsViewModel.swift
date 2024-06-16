//
//  RepositoryDetailsViewModel.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 10.06.2024.
//

import Foundation

final class RepositoryDetailsViewModel: ObservableObject {
    // MARK: - Property Wrappers
    
    @Published var markdownText: String?
    @Published var isLoading = false
    @Published var error: String?
    @Published var isReadmeNotFound = false
    
    // MARK: - Private Properties
    
    private(set) var content: Content?
    
    // MARK: - Public Methods
    
    func getContent(
        owner: String,
        repo: String,
        path: String
    ) {
        isLoading = true
        
        NetworkManager.shared.getContent(
            url: Api.content(owner: owner, repo: repo, path: path)
        ) { [weak self] result in
            switch result {
            case .success(let content):
                self?.isLoading = false
                self?.isReadmeNotFound = false
                self?.error = nil
                
                let cleanedEncodedContent = content.content
                    .replacingOccurrences(of: "\n", with: "")
                
                if let contentData = Data(base64Encoded: cleanedEncodedContent),
                   let decodedContent = String(
                    data: contentData,
                    encoding: .utf8
                   ) {
                    self?.content = content
                    self?.markdownText = decodedContent
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    
                    if error.statusCode == 404 {
                        self?.isReadmeNotFound = true
                    }
                    
                    self?.error = error.message
                }
            }
        }
    }
}
