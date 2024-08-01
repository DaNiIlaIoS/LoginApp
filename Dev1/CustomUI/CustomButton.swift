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
        let buttonConfig: UIButton.Configuration = {
            let config = UIButton.Configuration.plain()
            return config
        }()
        
        return {
            let button = UIButton(configuration: buttonConfig)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.backgroundColor = .gray
            button.setTitle(title, for: .normal)
            button.setImage(UIImage(systemName: image ?? ""), for: .normal)
            button.tintColor = .white
            button.layer.cornerRadius = 5
            
            button.contentHorizontalAlignment = .leading
            button.configuration?.imagePlacement = .leading
            button.configuration?.imagePadding = 20
            button.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 17)
                return outgoing
            })
            
            return button
        }()
    }
}
