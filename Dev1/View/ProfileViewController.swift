//
//  ProfileViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 21.07.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var avatarImage: UIImageView = {
       let image = UIImageView()
        image.image = .avatar
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 150).isActive = true
        image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        image.layer.cornerRadius = 75
        return image
    }()
    
    private lazy var nameLabel = CustomLabel.createLabel(text: "Daniil Sivozelezov")
    private lazy var mailLabel = CustomLabel.createSubtitle(text: "sivozelezov@gmail.com")
    private lazy var infoStackView = CustomStackView.createVerticalStack(distribution: .fillEqually, spacing: 0)
    
    private lazy var myAccountButton = CustomButton.createProfileButton(image: "person", title: "Мой аккаунт")
    private lazy var settingsButton = CustomButton.createProfileButton(image: "gearshape", title: "Настройки")
    private lazy var helpButton = CustomButton.createProfileButton(image: "message", title: "Помощь")
    private lazy var buttonsStackView = CustomStackView.createVerticalStack(distribution: .fill)
    
    private lazy var exitButton: UIButton = {
        let button = CustomButton.createProfileButton(image: nil, title: "Выход")
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        return button
    }()
    
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        title = "Мой профиль"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        view.backgroundColor = .black
        view.addSubview(avatarImage)
        view.addSubview(infoStackView)
        view.addSubview(buttonsStackView)
        view.addSubview(exitButton)
        
        infoStackView.addArrangedSubviews([nameLabel, mailLabel])
        buttonsStackView.addArrangedSubviews([myAccountButton,
                                             settingsButton,
                                             helpButton])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            avatarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoStackView.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            buttonsStackView.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            exitButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            exitButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor)
        ])
    }
    
    @objc func exitButtonAction() {
        NotificationCenter.default.post(Notification(name: Notification.Name("ChangeRegisterViewController")))
    }
}
