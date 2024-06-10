//
//  GitHubRepositoriesApp.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import SwiftUI

@main
struct GitHubRepositoriesApp: App {
    @State private var user: User?
    
    init() {
        setupNavigationBarAppearance()
    }
    
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
