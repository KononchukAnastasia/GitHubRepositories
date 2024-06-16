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
    
    private var isCanLoadNextPage = true
    private var page = 1
    private let perPage = 10
    
    func fetchRepos(url: String) {
        guard isCanLoadNextPage else { return }
        
        if page == 1 { isLoading = true }
        
        NetworkManager.shared.fetchRepos(
            url: url,
            perPage: perPage,
            page: page
        ) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.error = nil
                self?.repositories += repos
                self?.page += 1
                self?.isLoading = false
                self?.isCanLoadNextPage = repos.count == self?.perPage
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.isCanLoadNextPage = false
                    self?.error = error.message
                }
            }
        }
    }
    
    func onScrolledAtBottom(url: String, repository: Repository) {
        if repositories.last == repository {
            fetchRepos(url: url)
        }
    }
    
    func isShowLoader() -> Bool {
        guard isCanLoadNextPage, page != 1 else { return false }
        return true
    }
}
