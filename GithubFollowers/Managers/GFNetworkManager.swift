//
//  GFNetworkManager.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 13.10.2023.
//

import UIKit

final class GFNetworkManager {
    
    static let shared = GFNetworkManager()
    
    private let baseUrl = "https://api.github.com/users/"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    public func getFollowers(for username: String, page: Int, completion: @escaping (Result<[GFFollower], GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let urlString = URL(string: endpoint) else {
            completion(.failure(.invalidLoginName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {
            data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([GFFollower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
