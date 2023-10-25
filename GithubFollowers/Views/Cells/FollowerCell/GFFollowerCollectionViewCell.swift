//
//  GFFollowerCollectionViewCell.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 14.10.2023.
//

import UIKit
import SwiftUI

class GFFollowerCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "GFFollowerCollectionViewCell"
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    private let padding: CGFloat = 8
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Private
    
    public func set(follower: GFFollower) {
        if #available(iOS 16.0, *) {
            contentConfiguration = UIHostingConfiguration {
                GFFollowerView(follower: follower)
            }
        } else {
            avatarImageView.downloadImage(fromURL: follower.avatarUrl)
            usernameTitleLabel.text = follower.login
        }
    }
    
    private func configureSetup() {
        addSubViews(avatarImageView, usernameTitleLabel)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameTitleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameTitleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
}
