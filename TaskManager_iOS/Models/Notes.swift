//
//  Notes.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 11.08.2024.
//

import Foundation

struct Note: Decodable {
    let id: Int
    let title: String
    let text: String
    let created_at: String
}
