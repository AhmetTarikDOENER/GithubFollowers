//
//  GFFollowersItemViewController.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 19.10.2023.
//

import UIKit

class GFFollowersItemViewController: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .followers, with: user.followers)
        secondItemInfoView.set(itemInfoType: .following, with: user.following)
        actionButton.set(background: .systemGreen, title: "Get Followers.")
    }
    
    override func didTapActionButton() {
        guard user.followers != 0 else {
            presentGFCustomAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate?.gfDidTapGetFollowers(for: user)
    }
}
