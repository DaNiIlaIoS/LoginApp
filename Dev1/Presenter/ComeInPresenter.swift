//
//  ComeInPresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 21.07.2024.
//

import Foundation

protocol ComeInPresenterProtocol: AnyObject {
    func checkUserData(mail: String?, password: String?)
}

final class ComeInPresenter: ComeInPresenterProtocol {
    private let userData = UserData.shared
    weak var view: ComeInViewProtocol?
    
    init(view: ComeInViewProtocol?) {
        self.view = view
    }
    
    func checkUserData(mail: String?, password: String?) {
        guard let mail = mail, let password = password else { return }
        guard !mail.isEmpty, !password.isEmpty else { return }
        
        if userData.mail == mail,
           userData.password == password {
            view?.showNextViewController()
        } else {
            view?.showError()
        }
    }
}
