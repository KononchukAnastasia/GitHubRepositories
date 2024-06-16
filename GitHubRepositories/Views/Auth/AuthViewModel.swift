//
//  AuthViewModel.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    // MARK: - Property Wrappers
    
    @Published var error: String?
    @Published var isLoading = false
    
    // MARK: - Public Methods
    
    func fetchUser(token: String, completion: ((User) -> Void)?) {
        isLoading = true
        
        NetworkManager.shared.fetchUser(
            url: Api.user(),
            token: token
        ) { [weak self] result in
            switch result {
            case .success(let user):
                self?.isLoading = false
                self?.error = nil
                completion?(user)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.error = error.message
                }
            }
        }
    }
}
