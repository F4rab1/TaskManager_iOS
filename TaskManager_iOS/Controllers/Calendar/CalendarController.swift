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
    private let refreshController = UIRefreshControl()
    
    let dateFormatter = DateFormatter()
    var selectedDate: String
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter.string(from: Date())
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let calendarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "calendar")
        iv.tintColor = UIColor(red: 23, green: 162, blue: 184)
        return iv
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "August 22, 2024"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        return label
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        return tv
    }()
    
    private var tasksByCompletionDate: [Task]?
    var categoryDict: [String: String] = UserDefaults.standard.dictionary(forKey: "categories") as? [String: String] ?? [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarHorizontalController.delegate = self
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshTasksData(_:)), for: .valueChanged)
        
        setupUI()
        setupConstraints()
        setupTableView()
        fetchTodayTask()
    }
    
    func setupUI() {
        setupNavigationBarTitleView()
        view.addSubview(calendarHorizontalController.view)
        view.addSubview(tableView)
    }
    
    func fetchTodayTask() {
        APIService.shared.fetchTasksByCompletionDate(completionDate: selectedDate) { res, err in
            if let err = err {
                print(err)
            }
            
            DispatchQueue.main.async {
                self.tasksByCompletionDate = res
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func refreshTasksData(_ sender: Any) {
        APIService.shared.fetchTasksByCompletionDate(completionDate: selectedDate) { res, err in
            if let err = err {
                print(err)
            }
            
            DispatchQueue.main.async {
                self.tasksByCompletionDate = res
                self.tableView.reloadData()
                self.refreshController.endRefreshing()
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
    
    func setupNavigationBarTitleView() {
        let leftView = UIView()

        let calendarImageView = UIImageView()
        calendarImageView.contentMode = .scaleAspectFit
        calendarImageView.image = UIImage(systemName: "calendar")
        calendarImageView.tintColor = UIColor(red: 23/255, green: 162/255, blue: 184/255, alpha: 1)
        
        let dateLabel = UILabel()
        dateLabel.font = UIFont.boldSystemFont(ofSize: 18)
        dateLabel.textColor = .black
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        let todayDate = dateFormatter.string(from: Date())
        dateLabel.text = todayDate
        
        leftView.addSubview(calendarImageView)
        leftView.addSubview(dateLabel)
        
        calendarImageView.snp.makeConstraints { make in
            make.leading.equalTo(leftView)
            make.centerY.equalTo(leftView)
            make.height.width.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(calendarImageView.snp.trailing).offset(8)
            make.centerY.equalTo(leftView)
            make.trailing.equalTo(leftView)
        }
        
        leftView.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        let leftBarButtonItem = UIBarButtonItem(customView: leftView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.tableFooterView = UIView()
    }
    
}

extension CalendarController: CalendarHorizontalControllerDelegate {
    func didFetchTasksByCompletionDate(_ tasks: [Task], selectedDay: String) {
        DispatchQueue.main.async {
            self.tasksByCompletionDate = tasks
            self.selectedDate = selectedDay
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
        
        let task = tasksByCompletionDate?[indexPath.row]
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
        taskDetailController.task = tasksByCompletionDate?[indexPath.row]
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
        guard let task = tasksByCompletionDate?[indexPath.row] else { return }
        
        tasksByCompletionDate?.remove(at: indexPath.row)
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
