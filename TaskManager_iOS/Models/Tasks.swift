//
//  Task.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 27.07.2024.
//

import Foundation

struct Tasks: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [Task]
}

struct Task: Decodable {
    let id: Int
    let title: String
    let description: String
    let stage: String
    let priority: Int
    let category: Int
    let created_at: String
    let completion_date: String
}
