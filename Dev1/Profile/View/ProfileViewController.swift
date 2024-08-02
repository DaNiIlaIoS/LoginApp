//
//  ProfileViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 21.07.2024.
//

import UIKit
import SDWebImage

protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol! { get }
    func setAvatar(url: URL)
}

final class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    private lazy var avatarImage: UIImageView = {
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(tapToImage))
        
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapImage)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 150).isActive = true
        image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        image.layer.borderColor = UIColor.white.cgColor // Цвет обводки
        image.layer.borderWidth = 2.0 // Ширина обводки
        image.layer.cornerRadius = 75
        
        return image
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    private lazy var nameLabel = CustomLabel.createLabel(text: "")
    private lazy var emailLabel = CustomLabel.createSubtitle(text: presenter.email ?? "")
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
    
    var presenter: ProfilePresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadImageUrl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ProfilePresenter(view: self)
        
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
        
        infoStackView.addArrangedSubviews([nameLabel, emailLabel])
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
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    func setAvatar(url: URL) {
        avatarImage.sd_setImage(with: url, placeholderImage: .avatar)
    }
    
    @objc func tapToImage() {
        present(imagePicker, animated: true)
    }
    
    @objc func exitButtonAction() {
        presenter.signOut()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.avatarImage.image = image
            self.presenter.uploadImage(image: image)
        }
        picker.dismiss(animated: true)
    }
}
