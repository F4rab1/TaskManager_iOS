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
    private let tokenExpirationDateKey = "TokenExpirationDate"
    
    var accessToken: String? {
        get {
            if let expirationDate = UserDefaults.standard.object(forKey: tokenExpirationDateKey) as? Date,
               Date() > expirationDate {
                clearTokens()
                return nil
            }
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: accessTokenKey)
                let expirationDate = Date().addingTimeInterval(24 * 60 * 60)
                print(expirationDate)
                UserDefaults.standard.set(expirationDate, forKey: tokenExpirationDateKey)
            } else {
                clearTokens()
            }
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
    
    var isLoggedIn: Bool {
        return accessToken != nil
    }
    
    private func clearTokens() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
        UserDefaults.standard.removeObject(forKey: tokenExpirationDateKey)
    }
    
    private init() {}
}
