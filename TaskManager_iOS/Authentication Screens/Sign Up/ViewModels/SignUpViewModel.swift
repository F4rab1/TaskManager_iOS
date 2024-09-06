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
    
    func register(username: String, password: String, password2: String)
}

class SignUpViewModel: SignUpProtocol {
    
    var isRegistered: Bool = false
    
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    func register(username: String, password: String, password2: String) {
        
        let parameters: [String: Any] = ["username": username, "password": password, "password2": password2]
        
        APIService.shared.post(endpoint: "customers", parameters: parameters) { [weak self] result in
//
            
        }
    }
}
