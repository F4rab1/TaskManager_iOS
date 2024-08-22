//
//  NoteController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.08.2024.
//

import UIKit

class NotesController: UIViewController {
    
    private var notes: [Note]?
    private let refreshController = UIRefreshControl()
    
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, completionHandler) in
            self?.deleteNote(at: indexPath)
            completionHandler(true)
        }
        deleteAction.image = createCustomDeleteImage()
        deleteAction.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func deleteNote(at indexPath: IndexPath) {
        guard let note = notes?[indexPath.row] else { return }
        
        notes?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        APIService.shared.deleteNote(noteId: note.id) { error in
            if let error = error {
                print("Failed to delete note:", error)
            } else {
                print("Note successfully deleted from backend")
            }
        }
    }
}

func createCustomDeleteImage() -> UIImage? {
    let size = CGSize(width: 50, height: 50)
    let renderer = UIGraphicsImageRenderer(size: size)

    let image = renderer.image { context in
        let rect = CGRect(origin: .zero, size: size)
        
        UIColor.red.setFill()
        let roundedRectPath = UIBezierPath(roundedRect: rect, cornerRadius: 10)
        roundedRectPath.fill()

        if let trashImage = UIImage(systemName: "trash") {
            let imageSize = CGSize(width: 24, height: 24)
            let imageRect = CGRect(
                x: (size.width - imageSize.width) / 2,
                y: (size.height - imageSize.height) / 2,
                width: imageSize.width,
                height: imageSize.height
            )
            trashImage.withTintColor(.white).draw(in: imageRect)
        }
    }

    return image
}
