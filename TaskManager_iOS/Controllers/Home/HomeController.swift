//
//  MainController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 25.07.2024.
//

import UIKit

class HomeController: UIViewController {
    
    private var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.shared.fetchTasks { res, err in
            print(res)
        }
    }
    
}
