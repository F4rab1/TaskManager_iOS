//
//  NoteController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.08.2024.
//

import UIKit

class NotesController: UIViewController {
    
    private var notes: [Note]?
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes" 
        
        setupUI()
        setupConstraints()
        setupTableView()
        fetchNotes()
        
    }
    
    func setupUI() {
        view.addSubview(tableView)
    }
    
    func fetchNotes() {
        APIService.shared.fetchNotes() { res, err in
            if let err = err {
                print(err)
            }
            
            DispatchQueue.main.async {
                self.notes = res
                self.tableView.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.tableFooterView = UIView()
    }

}

extension NotesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        
        let note = notes?[indexPath.row]
        cell.titleLabel.text = note?.title
        cell.textOfNoteLabel.text = note?.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
