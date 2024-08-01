//
//  ComeInPresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 21.07.2024.
//

import Foundation

protocol ComeInPresenterProtocol: AnyObject {
    func checkUserData(email: String?, password: String?)
}

final class SignInPresenter: ComeInPresenterProtocol {
    private let signInModel = SignInModel()
    weak var view: SignInViewProtocol?
    
    init(view: SignInViewProtocol?) {
        self.view = view
    }
    
    func checkUserData(email: String?, password: String?) {
        guard let email = email, let password = password else { return }
        
        guard !email.isEmpty, !password.isEmpty else { return }
        
        let userData: AuthUserData = AuthUserData(email: email, password: password)
        
        signInModel.signIn(userData: userData) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.view?.showNextViewController()
                }
            case .failure(let failure):
                self?.view?.showError(message: failure.localizedDescription)
            }
        }
    }
}
