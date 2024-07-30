//
//  ProfilePresenter.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 30.07.2024.
//

import Foundation
import Firebase

protocol ProfilePresenterProtocol: AnyObject {
    var email: String? { get }
    func signOut()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    private let appModel = AppModel()
    
    let email: String? = Auth.auth().currentUser?.email
    
    func signOut() {
        appModel.signOut()
    }
}
