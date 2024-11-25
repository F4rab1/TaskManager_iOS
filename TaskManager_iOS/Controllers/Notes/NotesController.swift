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
    
    private let shadowAddButton: ShadowContainerView = {
        let view = ShadowContainerView(shadowColor: UIColor(red: 23, green: 162, blue: 184), shadowOpacity: 0.1, shadowRadius: 2, shadowOffset: CGSize(width: 0, height: 6))
        return view
    }()
    
    let addNoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Note", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 23, green: 162, blue: 184)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
        let customBarButton = UIBarButtonItem(customView: shadowAddButton)
        navigationItem.rightBarButtonItem = customBarButton
        
        setupUI()
        setupConstraints()
        setupTableView()
        fetchNotes()
        
    }
    
    func setupUI() {
        view.addSubview(tableView)
        shadowAddButton.addSubview(addNoteButton)
        
        addNoteButton.addTarget(self, action: #selector(handleAddNote), for: .touchUpInside)
    }
    
    func fetchNotes() {
        APIServiceNotes.shared.fetchNotes() { res, err in
            if let err = err {
                print(err)
            }
            
            DispatchQueue.main.async {
                self.notes = res
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func handleAddNote() {
        let controller = AddNoteController()
        controller.onNoteAdded = { [weak self] note in
            self?.notes?.append(note)
            self?.tableView.reloadData()
        }
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        shadowAddButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        addNoteButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
        cell.note = notes?[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes?[indexPath.row]
        let detailController = NoteDetailController()
        detailController.note = selectedNote
        navigationController?.pushViewController(detailController, animated: true)
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
        
        APIServiceNotes.shared.deleteNote(noteId: note.id) { error in
            if let error = error {
                print("Failed to delete note:", error)
            } else {
                print("Note successfully deleted from backend")
            }
        }
    }
}

extension NotesController: NoteTableViewCellDelegate {
    func didAddImage(toNote note: Note) {
        if let index = notes?.firstIndex(where: { $0.id == note.id }) {
            notes?[index] = note
        }
        
        tableView.reloadData()
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
