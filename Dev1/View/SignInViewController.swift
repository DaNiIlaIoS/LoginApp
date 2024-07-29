//
//  SignInViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

protocol SignInViewProtocol: AnyObject {
    func showNextViewController()
    func showError()
}

final class SignInViewController: UIViewController, SignInViewProtocol {
    
    // MARK: - GUI Variables
    private lazy var comeInLabel = CustomLabel.createLabel(text: "Войти")
    private lazy var emailTextField = CustomTextField.createTextField(placeholder: "Почта", keyboardType: .emailAddress)
    
    private lazy var passwordTextField: UITextField = {
        var showPasswordButton: UIButton = {
            let button = CustomButton.createShowPasswordButton()
            button.addTarget(self, action: #selector(showPassword), for: .touchDown)
            button.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
            return button
        }()
        
        let textField = CustomTextField.createTextField(placeholder: "Пароль")
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = CustomButton.createMainButton(title: "Войти")
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountLabel = CustomLabel.createSubtitle(text: "У вас нет аккаунта?")
    private lazy var registerButton: UIButton = {
        let button = CustomButton.createSubButton(title: "Регистрация")
        button.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalStackView = CustomStackView.createVerticalStack(distribution: .fillEqually)
    private lazy var horizontalStackView = CustomStackView.createHorizontalStack()
    
    // MARK: - Properties
    private var presenter: ComeInPresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ComeInPresenter(view: self)
        setupUI()
    }
    
    // MARK: - Private Properties
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(verticalStackView)
        view.addSubview(horizontalStackView)
        
        verticalStackView.addArrangedSubviews([comeInLabel,
                                              emailTextField,
                                              passwordTextField,
                                               UIView(),
                                              signInButton])
        horizontalStackView.addArrangedSubviews([createAccountLabel,
                                                registerButton])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 20),
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func showError() {
        // TODO: alert controller
    }
    
    func showNextViewController() {
        NotificationCenter.default.post(Notification(name: Notification.Name("OpenProfileViewController")))
    }
    
    @objc func registerButtonAction() {
        NotificationCenter.default.post(Notification(name: Notification.Name("OpenRegistrationViewController")))
    }
    
    @objc func signInButtonAction() {
        presenter?.checkUserData(mail: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func hidePassword() {
        // Скрываем пароль, когда кнопка отпускается внутри её границ
        passwordTextField.isSecureTextEntry.toggle()
    }
}
