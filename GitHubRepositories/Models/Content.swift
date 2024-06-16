//
//  Content.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 10.06.2024.
//

import Foundation

struct Content: Decodable {
    // MARK: - Public Properties
    
    let content: String
    let downloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case content
        case downloadUrl = "download_url"
    }
}
