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
    
    public func getFollowers(for username: String, page: Int, completion: @escaping ([GFFollower]?, String?) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let urlString = URL(string: endpoint) else {
            completion(nil, "This username occured an invalid request. Please try again later.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlString) {
            data, response, error in
            
            if let _ = error {
                completion(nil, "There is an issue to complete your request. Please check your internet connection.!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid server response. Please try again")
                return
            }
            
            guard let data = data else {
                completion(nil, "Invalid data from the server.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([GFFollower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "The received data occurs an error. Please try again later.")
            }
        }
        task.resume()
    }
    
}
