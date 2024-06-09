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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case htmlURL = "html_url"
        case description
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
    }
}

extension Repository {
    static func getRepositories() -> [Repository] {
        [
//            Repository(name: <#T##String#>, htmlURL: <#T##String#>, description: <#T##String?#>, stargazersCount: <#T##Int#>, watchersCount: <#T##Int#>, language: <#T##String?#>, forksCount: <#T##Int#>),
//            Repository(name: <#T##String#>, htmlURL: <#T##String#>, description: <#T##String?#>, stargazersCount: <#T##Int#>, watchersCount: <#T##Int#>, language: <#T##String?#>, forksCount: <#T##Int#>)
        ]
    }
}
