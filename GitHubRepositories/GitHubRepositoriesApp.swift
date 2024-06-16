//
//  GitHubRepositoriesApp.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import SwiftUI

@main
struct GitHubRepositoriesApp: App {
    // MARK: - Property Wrappers
    
    @State private var user: User?
    
    // MARK: - Initializers
    
    init() {
        setupNavigationBarAppearance()
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            if user != nil {
                RepositoriesView(user: $user)
            } else {
                AuthView(
                    onSuccessAuth: { user in
                        self.user = user
                    }
                )
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
