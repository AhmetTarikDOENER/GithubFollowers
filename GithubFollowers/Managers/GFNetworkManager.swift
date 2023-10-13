//
//  GFNetworkManager.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 13.10.2023.
//

import Foundation

final class GFNetworkManager {
    
    static let shared = GFNetworkManager()
    
    private let baseUrl = "https://api.github.com/users/"
    
    private init() { }
    
    public func getFollowers(for username: String, page: Int, completion: @escaping ([GFFollower]?, GFErrorMessage?) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let urlString = URL(string: endpoint) else {
            completion(nil, .invalidLoginName)
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {
            data, response, error in
            
            if let _ = error {
                completion(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([GFFollower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, .invalidData)
            }
        }
        task.resume()
    }
    
}
