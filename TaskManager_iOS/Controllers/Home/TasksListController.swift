//
//  TasksListController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 03.12.2024.
//

import UIKit

class TasksListController: UIViewController {
    
    var tasks: [Task]?
    private let refreshController = UIRefreshControl()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home Page"
        view.backgroundColor = .white
        
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshTasksData(_:)), for: .valueChanged)
        
        APIService.shared.fetchTasks { res, err in
            DispatchQueue.main.async {
                self.tasks = res
                self.tableView.reloadData()
            }
        }
        
        setupUI()
        setupConstraints()
        setupTableView()
        
    }
    
    func setupUI() {
        view.addSubview(tableView)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
    }
    
    @objc func refreshTasksData(_ sender: Any) {
        APIService.shared.fetchTasks { res, err in
            DispatchQueue.main.async {
                self.tasks = res
                self.tableView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension TasksListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        
        let task = tasks?[indexPath.row]
        cell.categoryLabel.text = task?.category
        cell.titleLabel.text = task?.title
        if task?.stage == "completed" {
            cell.isCompleted = true
        } else {
            cell.isCompleted = false
        }
        switch task?.priority {
        case 1:
            cell.priorityLabel.text = "LOW"
        case 2:
            cell.priorityLabel.text = "MEDIUM"
        case 3:
            cell.priorityLabel.text = "HIGH"
        default:
            cell.priorityLabel.text = "NULL"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskDetailController = TaskDetailController()
        taskDetailController.task = tasks?[indexPath.row]
        navigationController?.pushViewController(taskDetailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.deleteTask(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = createCustomDeleteImage()
        deleteAction.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func deleteTask(at indexPath: IndexPath) {
        guard let task = tasks?[indexPath.row] else { return }
        
        tasks?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        APIService.shared.deleteTask(taskId: task.id) { error in
            if let error = error {
                print("Failed to delete task:", error)
            } else {
                print("Task successfully deleted from backend")
            }
        }
    }
    
}

