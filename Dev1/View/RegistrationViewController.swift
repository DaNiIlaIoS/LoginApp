//
//  RegistrationViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private lazy var titleLabel = CustomLabel.createLabel(text: "Регистрация")
    private lazy var noAccountLabel = CustomLabel.createSubtitle(text: "Уже есть аккаунт?")
    
    private lazy var nameTextField = CustomTextField.createTextField(placeholder: "Имя")
    private lazy var mailTextField = CustomTextField.createTextField(placeholder: "Почта")
    
    private lazy var showPasswordButton: UIButton = {
        let button = CustomButton.createShowPasswordButton()
        button.addTarget(self, action: #selector(showPassword), for: .touchDown)
        button.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = CustomTextField.createTextField(placeholder: "Пароль")
        textField.isSecureTextEntry = true
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Я согласен с Условиями предоставления услуг и Политикой конфиденциальности"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    lazy var emptyView = UIView()
    
    private lazy var registrationButton: UIButton = {
        let button = CustomButton.createMainButton(title: "Регистрация")
        return button
    }()
    
    private lazy var comeInButton: UIButton = {
        let button = CustomButton.createSubButton(title: "Войти".uppercased())
        return button
    }()
    
    private lazy var verticalStackView = CustomStackView.createVerticalStack()
    private lazy var horizontalStackView = CustomStackView.createHorizontalStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(verticalStackView)
        view.addSubview(horizontalStackView)
        
        verticalStackView.addArrangedSubviews([titleLabel,
                                               nameTextField,
                                               mailTextField,
                                               passwordTextField,
                                               conditionLabel,
                                               registrationButton])
        
        horizontalStackView.addArrangedSubviews([noAccountLabel, comeInButton])
        
        nameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 20),
            //            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            //            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func hidePassword() {
        // Скрываем пароль, когда кнопка отпускается внутри её границ
        passwordTextField.isSecureTextEntry.toggle()
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameTextField.isFirstResponder {
            mailTextField.becomeFirstResponder()
        } else if mailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
