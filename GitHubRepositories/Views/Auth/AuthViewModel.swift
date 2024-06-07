//
//  AuthViewModel.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var error: String?
    @Published var isLoading = false
    
    func fetchUser(token: String) {
        isLoading = true
        
        NetworkManager.shared.fetchUser(
            url: Api.user,
            token: token
        ) { [weak self] result in
            switch result {
            case .success(let user):
                self?.isLoading = false
                self?.error = nil
                self?.user = user
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.error = error.rawValue
                }
            }
        }
    }
}
