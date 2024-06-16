//
//  User.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

struct User: Decodable {
    // MARK: - Public Properties
    
    let login: String
    let reposUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case reposUrl = "repos_url"
    }
}

// MARK: - Extension User

extension User {
    static func getUser() -> User {
        User(
            login: "KononchukAnastasia",
            reposUrl: "https://api.github.com/users/KononchukAnastasia/repos"
        )
    }
}
