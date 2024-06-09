//
//  AppStorageManager.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 08.06.2024.
//

import SwiftUI

class AppStorageManager {
    // MARK: - Property Wrappers
    
    @AppStorage("login") private var login: String?
    
    // MARK: - Public Properties
    
    static let shared = AppStorageManager()
    
    // MARK: - Private Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    func saveLogin(_ login: String) {
        self.login = login
    }
    
    func deleteLogin() {
        login = nil
    }
    
    func getLogin() -> String? {
        guard let login = login else { return nil }
        return login
    }
}
