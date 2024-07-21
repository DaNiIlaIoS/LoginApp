//
//  CustomButton.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

final class CustomButton {
    static func createMainButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.setTitle(title, for: .normal)
        button.backgroundColor = .appViolet
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 15
        return button
    }
    
    static func createShowPasswordButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.tintColor = .lightGray
        return button
    }
    
    static func createSubButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.appViolet, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }
    
    static func createProfileButton(image: String?, title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .gray
        button.setTitle(title, for: .normal)
        button.setImage(UIImage(systemName: image ?? ""), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.contentHorizontalAlignment = .leading
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        
        return button
    }
}
