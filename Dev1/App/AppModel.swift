//
//  AppModel.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 30.07.2024.
//

import Foundation
import Firebase

final class AppModel {
    func isUserLogin() -> Bool {
        return Auth.auth().currentUser?.uid != nil ? true : false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            NotificationCenter.default.post(name: Notification.Name("OpenSignInViewController"), object: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
}
