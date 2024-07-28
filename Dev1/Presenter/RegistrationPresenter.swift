//
//  RegistrationPresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import Foundation

protocol RegistrationPresenterProtocol: AnyObject {
    func registerUser(name: String?, email: String?, password: String?)
}

final class RegistrationPresenter: RegistrationPresenterProtocol {
    
    private let userData = UserData.shared
    private let registerModel = RegistrationModel()
    weak var view: RegistrationViewProtocol?
    
    init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func registerUser(name: String?, email: String?, password: String?) {
        guard let name = name, let email = email, let password = password else {
            print("User data is nil")
            return
        }
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            print("Please fill in all fields")
            return
        }
        
        userData.name = name
        userData.email = email
        userData.password = password
        
        let regData = UserRegData(name: userData.name, email: userData.email, password: userData.password)
        
        self.registerModel.createUser(user: regData) { result in
            switch result {
            case .success(let success):
                if success {
                    NotificationCenter.default.post(Notification(name: Notification.Name("ChangeRegisterViewController")))
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
