//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 14.10.2023.
//

import UIKit

/// Custom image view for avatars
class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = Images.placeHolderImage
    private let cache = GFNetworkManager.shared.cache
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Private
    
    private func configureSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
    
    func downloadImage(fromURL url: String) {
        Task {
            image = await GFNetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
    }
}
