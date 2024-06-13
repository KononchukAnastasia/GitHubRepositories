//
//  Api.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

struct Api {
    // MARK: - Private Properties
    
    private static var baseUrl = "https://api.github.com"
    
    // MARK: - Public Methods
    
    static func user() -> String {
        createEndpoint(["user"])
    }
    
    static func content(owner: String, repo: String, path: String) -> String {
        createEndpoint(["repos", owner, repo, "contents", path])
    }
    
    // MARK: - Private Methods
    
    private static func createEndpoint(_ components: [String]) -> String {
        var components = components
        components.insert(baseUrl, at: 0)
        
        return components.joined(separator: "/")
    }
}
