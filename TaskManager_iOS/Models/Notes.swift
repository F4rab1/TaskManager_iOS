//
//  Notes.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 11.08.2024.
//

import Foundation

struct Note: Decodable {
    let id: Int
    var title: String
    var text: String
    let created_at: String
    var images: [NoteImage]
}

struct NoteImage: Decodable {
    let id: Int
    let image_link: String
}
