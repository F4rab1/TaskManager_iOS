//
//  Task.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 27.07.2024.
//

import Foundation

struct Task: Decodable {
    let id: Int
    let title: String
    let description: String
    let stage: String
    let category: String
    let created_at: String
    let completion_date: String
}
