//
//  GFCustomButton.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 12.10.2023.
//

import UIKit

/// Reusable custom button
class GFCustomButton: UIButton {

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    //MARK: - Private
    
    private func configureSetup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    func set(background: UIColor, title: String) {
        self.backgroundColor = background
        setTitle(title, for: .normal)
    }
    
}
