//
//  RegistrationModel.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 28.07.2024.
//

import Foundation
import Firebase

struct UserRegData {
    let name: String
    let email: String
    let password: String
}

final class RegistrationModel {
    func createUser(user: UserRegData, completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            if let error = error {
                completion(.failure(error))
            } else if let userId = result?.user.uid {
                result?.user.sendEmailVerification()
                self?.setUserData(uid: userId, name: user.name, password: user.password)
                completion(.success(true))
            }
        }
    }
    
    private func setUserData(uid: String, name: String, password: String) {
        let userData: [String: Any] = ["name": name, "password": password]
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData(userData) { error in
                print("is add")
            }
    }
}
