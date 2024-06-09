//
//  User.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

struct User: Decodable {
    let login: String
    let reposUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case reposUrl = "repos_url"
    }
}

extension User {
    static func getUser() -> User {
        User(
            login: "KononchukAnastasia",
            reposUrl: "https://api.github.com/users/KononchukAnastasia/repos"
        )
    }
}
