//
//  LoginViewModel.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 31.08.2024.
//

import Foundation
import UIKit

protocol LoginProtocol {
    var isLoggedIn: Bool { get }
    var loginResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func login(username: String, password: String)
}

class LoginViewModel: LoginProtocol {
    
    var isLoggedIn: Bool = false
    var loginResult: ((Result<Data, Error>) -> Void)?
    
    func login(username: String, password: String) {
        let parameters: [String: Any] = ["username": username, "password": password]

        APIService.shared.post(endpoint: "token/", parameters: parameters) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let tokenResponse = try? decoder.decode(TokenResponse.self, from: data) {
                        AuthManager.shared.accessToken = tokenResponse.access
                        AuthManager.shared.refreshToken = tokenResponse.refresh
                        
                        self?.isLoggedIn = true
                        self?.loginResult?(.success(data))
                    }
                case .failure(let error):
                    print("Failed register number: \(error.localizedDescription)")
                    self?.isLoggedIn = false
                    self?.loginResult?(.failure(error))
                }
            }
        }
    }
}
