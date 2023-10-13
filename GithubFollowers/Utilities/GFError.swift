//
//  GFErrorMessage.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 14.10.2023.
//

import Foundation

enum GFError: String, Error {
    case invalidLoginName = "This username occured an invalid request. Please try again later."
    case unableToComplete = "There is an issue to complete your request. Please check your internet connection.!"
    case invalidResponse = "Invalid server response. Please try again"
    case invalidData = "Invalid data from the server."
}
