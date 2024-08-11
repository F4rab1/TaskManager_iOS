//
//  NoteController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.08.2024.
//

import UIKit

class NotesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.fetchNotes { res, err in
            print(res)
        }

        view.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
    }

}
