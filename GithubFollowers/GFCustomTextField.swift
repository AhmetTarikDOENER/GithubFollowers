//
//  GFCustomTextField.swift
//  GithubFollowers
//
//  Created by Ahmet Tarik DÖNER on 12.10.2023.
//

import UIKit

class GFCustomTextField: UITextField {

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Private
    
    private func setupConfiguration() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10; layer.borderWidth = 2; layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label; textAlignment = .center; tintColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2); adjustsFontSizeToFitWidth = true; minimumFontSize = 15
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "Enter a username"
    }
    
}
