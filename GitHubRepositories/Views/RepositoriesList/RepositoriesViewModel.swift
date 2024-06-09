//
//  RepositoriesViewModel.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 08.06.2024.
//

import Foundation

final class RepositoriesViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var isLoading = false
    @Published var error: String?
    
    func fetchRepos(url: String) {
        isLoading = true
        
        NetworkManager.shared.fetchRepos(url: url) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.isLoading = false
                self?.error = nil
                self?.repositories = repos
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.error = error.rawValue
                }
            }
        }
    }
}
