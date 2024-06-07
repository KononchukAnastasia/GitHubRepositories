//
//  NetworkManager.swift
//  GitHubRepositories
//
//  Created by Анастасия Конончук on 06.06.2024.
//

import Foundation

enum NetworkError: LocalizedError {
    // Invalid request, e.g. invalid URL.
    case badURL(String = "Bad URL or nil.")
    
    // Indicates an error on the transport layer,
    // e.g. not being able to connect to the server.
    case transportError(Error)
    
    // Received an bad response, e.g. non HTTP result.
    case badResponse(String)
    
    // No decode data.
    case noDecodedData(String = "The data couldn’t be read because it isn’t in the correct format.")
    
    var rawValue: String {
        switch self {
        case .badURL(let message):
            return message
        case .transportError(let error):
            return error.localizedDescription
        case .badResponse(let message):
            return message
        case .noDecodedData(let message):
            return message
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUser(
        url: String,
        token: String,
        completion: @escaping (Result<User, NetworkError>) -> ()
    ) {
        guard let url = URL(string: url) else {
            return completion(.failure(.badURL()))
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 401 {
                    completion(.failure(.badResponse("Invalid token.")))
                    return
                } else if !(200...299).contains(httpResponse.statusCode) {
                    let message = "Bad response.\nStatus code:"
                    let error = "\(message) \(httpResponse.statusCode)"
                    
                    completion(.failure(.badResponse(error)))
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            } catch {
                completion(.failure(.noDecodedData()))
            }
        }.resume()
    }
}
