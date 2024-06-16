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
    case badResponse(String, Int)
    
    // No decoded data.
    case noDecodedData(String = "The data couldn’t be read because it isn’t in the correct format.")
    
    var message: String {
        switch self {
        case .badURL(let message):
            return message
        case .transportError(let error):
            return error.localizedDescription
        case .badResponse(let message, _):
            return message
        case .noDecodedData(let message):
            return message
        }
    }
    
    var statusCode: Int? {
        switch self {
        case .badURL(_):
            return nil
        case .transportError(_):
            return nil
        case .badResponse(_, let statusCode):
            return statusCode
        case .noDecodedData(_):
            return nil
        }
    }
}

final class NetworkManager {
    // MARK: - Public Properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
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
                let statusCode = httpResponse.statusCode
                
                if statusCode == 401 {
                    completion(
                        .failure(.badResponse("Invalid token.", statusCode))
                    )
                    
                    return
                } else if !(200...299).contains(statusCode) {
                    let message = "Bad response.\nStatus code:"
                    let error = "\(message) \(statusCode)"
                    
                    completion(.failure(.badResponse(error, statusCode)))
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
    
    func fetchRepos(
        url: String,
        perPage: Int,
        page: Int,
        completion: @escaping (Result<[Repository], NetworkError>) -> ()
    ) {
        guard let url = URL(string: url) else {
            return completion(.failure(.badURL()))
        }
        
        let parameters: [String: String] = [
            "per_page": String(perPage),
            "page": String(page)
        ]
        
        var request = URLRequest(url: url)
        request.url = createQuery(for: url, parameters: parameters)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let repositories = try JSONDecoder().decode(
                    [Repository].self,
                    from: data
                )
                
                DispatchQueue.main.async {
                    completion(.success(repositories))
                }
            } catch {
                completion(.failure(.noDecodedData()))
            }
        }.resume()
    }
    
    func getContent(
        url: String,
        completion: @escaping (Result<Content, NetworkError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            return completion(.failure(.badURL()))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                if statusCode == 404 {
                    completion(
                        .failure(.badResponse("Readme not found.", statusCode))
                    )
                    
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let content = try JSONDecoder().decode(
                    Content.self,
                    from: data
                )
                
                DispatchQueue.main.async {
                    completion(.success(content))
                }
            } catch {
                completion(.failure(.noDecodedData()))
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    
    private func createQuery(
        for url: URL,
        parameters: [String: String]
    ) -> URL? {
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )
        
        components?.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return components?.url
    }
}
