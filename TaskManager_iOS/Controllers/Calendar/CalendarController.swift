//
//  CalendarController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 25.07.2024.
//

import UIKit
import SnapKit

class CalendarController: UIViewController {
    
    let calendarHorizontalController = CalendarHorizontalController()
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        return tv
    }()
    
    private var tasksByCompletionDate: Tasks?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarHorizontalController.delegate = self
        
        setupUI()
        setupConstraints()
        setupTableView()
        fetchTodayTask()
    }
    
    func setupUI() {
        view.addSubview(calendarHorizontalController.view)
        view.addSubview(tableView)
    }
    
    func fetchTodayTask() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayDate = dateFormatter.string(from: Date())
        
        APIService.shared.fetchTasksByCompletionDate(completionDate: todayDate) { res, err in
            if let err = err {
                print(err)
            }
            
            DispatchQueue.main.async {
                self.tasksByCompletionDate = res
                self.tableView.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        calendarHorizontalController.view.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(120)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(calendarHorizontalController.view.snp.bottom).offset(10)
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.tableFooterView = UIView()
    }
    
}

extension CalendarController: CalendarHorizontalControllerDelegate {
    func didFetchTasksByCompletionDate(_ tasks: Tasks) {
        DispatchQueue.main.async {
            self.tasksByCompletionDate = tasks
            self.tableView.reloadData()
        }
    }
}

extension CalendarController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksByCompletionDate?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        
        let task = tasksByCompletionDate?.results[indexPath.row]
        cell.categoryLabel.text = task?.category
        cell.titleLabel.text = task?.title
        cell.stageLabel.text = task?.stage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDetailController = TaskDetailController()
        navigationController?.pushViewController(taskDetailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
