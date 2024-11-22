//
//  AddNoteController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 27.08.2024.
//

import UIKit
import SnapKit

class AddNoteController: UIViewController, UITextViewDelegate {
    
    var onNoteAdded: ((Note) -> Void)?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Add Note"
        
        return label
    }()
    
    let titleNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()
    
    let titleFieldNote: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter title of Note here"
        tf.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.size.height))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf
    }()
    
    let textNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()
    
    let noteTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.layer.borderColor = UIColor(red: 23, green: 162, blue: 184).cgColor
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 10
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        tv.isScrollEnabled = true
        tv.text = "Enter text of Note here"
        tv.textColor = .lightGray
        
        return tv
    }()
    
    let addPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "You may add photos later from the notes page!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
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
        
        noteTextView.delegate = self
        
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        addNoteButton.addTarget(self, action: #selector(postNote), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(titleNoteLabel)
        view.addSubview(titleFieldNote)
        view.addSubview(textNoteLabel)
        view.addSubview(noteTextView)
        view.addSubview(addPhotoLabel)
        view.addSubview(addNoteButton)
    }
    
    @objc func postNote() {
        guard let title = titleFieldNote.text, !title.isEmpty,
              let text = noteTextView.text, text != "Enter text of Note here", !text.isEmpty else {
            
            return
        }
        
        APIServiceNotes.shared.postNote(title: title, text: text) { [weak self] note, err in
            if let err = err {
                print("Failed to post note:", err)
                return
            }
            
            if let note = note {
                print("Successfully posted note:", note)
                
                DispatchQueue.main.async {
                    self?.onNoteAdded?(note)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func clearPlaceholder() {
        if noteTextView.text == "Enter text of Note here" && noteTextView.textColor == .lightGray {
            noteTextView.text = nil
            noteTextView.textColor = .black
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter text of Note here"
            textView.textColor = .lightGray
        }
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        titleNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        titleFieldNote.snp.makeConstraints { make in
            make.top.equalTo(titleNoteLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        textNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleFieldNote.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(20)
        }
        
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(textNoteLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
        
        addPhotoLabel.snp.makeConstraints { make in
            make.top.equalTo(noteTextView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addNoteButton.snp.makeConstraints { make in
            make.top.equalTo(addPhotoLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }
    
}
