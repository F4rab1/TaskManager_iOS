//
//  SignUpResponse.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 29.11.2024.
//

import Foundation

struct SignUpResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let first_name: String
    let last_name: String
}
