//
//  UserData.swift
//  Dev1
//
//  Created by Даниил Сивожелезов on 20.07.2024.
//

import Foundation

final class UserData {
    static let shared = UserData()
    private init() {}
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
}
