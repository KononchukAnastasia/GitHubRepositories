//
//  Repository.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 08.06.2024.
//

import Foundation

struct Repository: Decodable, Hashable {
    let id: Int
    let name: String
    let htmlURL: String
    let description: String?
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let forksCount: Int
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case htmlURL = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case owner
    }
}

struct Owner: Decodable, Hashable {
    let login: String
}

extension Repository {
    static func getRepository() -> Repository {
            Repository(
                id: 800065832,
                name: "WarSnake",
                htmlURL: "https://github.com/KononchukAnastasia/WarSnake",
                description: "Game written using the framework SpriteKit.",
                stargazersCount: 3,
                watchersCount: 0,
                language: "Swift",
                forksCount: 0,
                owner: Owner(login: "KononchukAnastasia")
            )
    }
}
