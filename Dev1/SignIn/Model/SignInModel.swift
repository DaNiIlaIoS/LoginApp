//
//  SignInModel.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 29.07.2024.
//

import Foundation
import Firebase

struct AuthUserData {
    let email: String
    let password: String
}

final class SignInModel {
    func signIn(userData: AuthUserData, completion: @escaping (Result<Bool, Error>) -> ()) {
        Auth.auth().signIn(withEmail: userData.email, password: userData.password) { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
//            if let isVerified = result?.user.isEmailVerified, isVerified {
//                completion(.success(true))
//            } else {
//                completion(.success(false))
//            }
            
            if let _ = result?.user.uid {
                completion(.success(true))
            }
        }
    }
}
