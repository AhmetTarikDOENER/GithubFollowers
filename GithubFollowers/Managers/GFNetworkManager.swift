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
    
    public func getUserInfo(for username: String, completion: @escaping (Result<GFUser, GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)"
        
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
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(GFUser.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            [weak self] data, response, error in
            guard let self = self,
                    error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
}
