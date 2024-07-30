//
//  RegistrationViewController.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func showError()
    func signInButtonAction()
}

class RegistrationViewController: UIViewController, RegistrationViewProtocol {
    
    // MARK: - GUI Variables
    private lazy var titleLabel = CustomLabel.createLabel(text: "Регистрация")
    private lazy var noAccountLabel = CustomLabel.createSubtitle(text: "Уже есть аккаунт?")
    
    private lazy var nameTextField = CustomTextField.createTextField(placeholder: "Имя", autocapitalizationType: .words)
    private lazy var emailTextField = CustomTextField.createTextField(placeholder: "Почта", keyboardType: .emailAddress)
    
    private lazy var passwordTextField: UITextField = {
        var showPasswordButton: UIButton = {
            let button = CustomButton.createShowPasswordButton()
            button.addTarget(self, action: #selector(showPassword), for: .touchDown)
            button.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
            return button
        }()
        
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        rightViewContainer.addSubview(showPasswordButton)
        
        rightViewContainer.translatesAutoresizingMaskIntoConstraints = false
        showPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightViewContainer.widthAnchor.constraint(equalToConstant: 50),
            rightViewContainer.heightAnchor.constraint(equalToConstant: 50),
            
            showPasswordButton.trailingAnchor.constraint(equalTo: rightViewContainer.trailingAnchor, constant: -15),
            showPasswordButton.centerYAnchor.constraint(equalTo: rightViewContainer.centerYAnchor),
        ])
        
        let textField = CustomTextField.createTextField(placeholder: "Пароль")
        textField.isSecureTextEntry = true
        textField.rightView = rightViewContainer
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
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = CustomButton.createSubButton(title: "Войти".uppercased())
        button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var textFieldsStackView = CustomStackView.createVerticalStack(distribution: .fillEqually)
    private lazy var horizontalStackView = CustomStackView.createHorizontalStack()
    
    // MARK: - Properties
    private var presenter: RegistrationPresenterProtocol?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegistrationPresenter(view: self)
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(textFieldsStackView)
        view.addSubview(horizontalStackView)
        
        textFieldsStackView.addArrangedSubviews([titleLabel,
                                               nameTextField,
                                               emailTextField,
                                               passwordTextField,
                                               conditionLabel,
                                               registrationButton])
        
        horizontalStackView.addArrangedSubviews([noAccountLabel, signInButton])
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            textFieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            textFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            horizontalStackView.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
            //            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            //            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func showError() {
        // TODO: Create alert controller
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func hidePassword() {
        // Скрываем пароль, когда кнопка отпускается внутри её границ
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc func registerButtonTapped() {
        presenter?.registerUser(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func signInButtonAction() {
        NotificationCenter.default.post(Notification(name: Notification.Name("OpenSignInViewController")))
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameTextField.isFirstResponder {
            emailTextField.becomeFirstResponder()
        } else if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}
