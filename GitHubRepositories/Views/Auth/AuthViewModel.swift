//
//  AuthViewModel.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var user: User?
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
                self?.user = user
                print("**** \(user)")
            case .failure(let error):
                self?.isLoading = false
                print(error.localizedDescription)
            }
        }
    }
}
