//
//  MainController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 25.07.2024.
//

import UIKit

class HomeController: UIViewController {
    
    private var tasks: [Task]?
    
    let allTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("All Tasks", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        APIService.shared.fetchTasks { res, err in
            self.tasks = res
        }
        
    }
    
    func setupUI() {
        view.addSubview(allTaskButton)
        
        allTaskButton.addTarget(self, action: #selector(allTaskButtonhandle), for: .touchUpInside)
    }
    
    @objc func allTaskButtonhandle() {
        let tasksController = TasksListController()
        tasksController.tasks = self.tasks
        navigationController?.pushViewController(tasksController, animated: true)
    }
    
    func setupConstraints() {
        allTaskButton.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
}
