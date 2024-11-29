//
//  SignUpViewModel.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 05.09.2024.
//

import Foundation
import UIKit

protocol SignUpProtocol {
    var isRegistered: Bool { get }
    var registerResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func register(username: String, password: String, email: String, first_name: String, last_name: String)
}

class SignUpViewModel: SignUpProtocol {
    
    var isRegistered: Bool = false
    
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    func register(username: String, password: String, email: String, first_name: String, last_name: String) {
        let parameters: [String: Any] = ["username": username, "password": password, "email": email, "first_name": first_name, "last_name": last_name]
        
        APIService.shared.post(endpoint: "auth/users/", parameters: parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let signUpResponse = try? decoder.decode(SignUpResponse.self, from: data) {
                        self?.isRegistered = true
                        self?.registerResult?(.success(data))
                    }
                case .failure(let error):
                    print("Failed register number: \(error.localizedDescription)")
                    self?.isRegistered = false
                    self?.registerResult?(.failure(error))
                }
            }
        }
    }
    
}
