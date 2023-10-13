//
//  GFUser.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 13.10.2023.
//

import Foundation

struct GFUser: Codable {
    
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
