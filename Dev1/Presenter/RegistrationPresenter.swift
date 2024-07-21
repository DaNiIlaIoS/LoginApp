//
//  RegistrationPresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func registerUser(name: String?, mail: String?, password: String?)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    private let userData = UserData.shared
    weak var view: RegistrationViewProtocol?
    
    init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func registerUser(name: String?, mail: String?, password: String?) {
        guard let name = name, let mail = mail, let password = password else {
            print("User data is nil")
            return
        }
        guard !name.isEmpty, !mail.isEmpty, !password.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        userData.name = name
        userData.mail = mail
        userData.password = password
        
        view?.showNextViewController()
    }
}
