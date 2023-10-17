//
//  GFUser.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 13.10.2023.
//

import Foundation

struct GFUser: Codable {
    
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
