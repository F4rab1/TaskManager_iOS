//
//  AuthManager.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 31.08.2024.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    private let accessTokenKey = "AccessToken"
    private let refreshTokenKey = "RefreshToken"
    
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
    
    private init() {}
}
