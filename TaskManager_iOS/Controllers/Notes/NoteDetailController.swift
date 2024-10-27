//
//  NoteDetailController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 01.09.2024.
//

import UIKit
import SnapKit
import SDWebImage

class NoteDetailController: UIViewController, UITextViewDelegate {
    
    var note: Note? {
        didSet {
            titleFieldNote.text = note?.title
            noteTextView.text = note?.text
        }
    }
    
    let titleNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 23, green: 162, blue: 184)
        
        return label
    }()
    
    let titleFieldNote: UITextField = {
        let tf = UITextField()
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
        tv.textColor = .black
        
        return tv
    }()
    
    let photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 100, height: 100)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let editNoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Note", for: .normal)
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
    }
    
    func setupUI() {
        view.backgroundColor = .white
        editNoteButton.addTarget(self, action: #selector(editNote), for: .touchUpInside)
        titleFieldNote.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        noteTextView.delegate = self
        
        view.addSubview(titleNoteLabel)
        view.addSubview(titleFieldNote)
        view.addSubview(textNoteLabel)
        view.addSubview(noteTextView)
        view.addSubview(photoCollectionView)
        view.addSubview(editNoteButton)
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(NotePhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    @objc func textDidChange() {
        updateEditButtonState()
    }
    
    func updateEditButtonState() {
        if titleFieldNote.text != note?.title || noteTextView.text != note?.text {
            editNoteButton.backgroundColor = UIColor(red: 23, green: 162, blue: 184)
        } else {
            editNoteButton.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateEditButtonState()
    }
    
    @objc func editNote() {
        guard let title = titleFieldNote.text,
              let text = noteTextView.text,
              title != note?.title || text != note?.text,
              let token = AuthManager.shared.accessToken else {
            return
        }
        
        let parameters: [String: Any] = [
            "title": title,
            "text": text
        ]
        
        APIService.shared.putWithToken(endpoint: "notes/\(note!.id)/", parameters: parameters, token: token) { result in
            switch result {
            case .success(let data):
                print("Note updated successfully: \(data)")
                DispatchQueue.main.async {
                    self.note?.title = title
                    self.note?.text = text
                    self.updateEditButtonState()
                }
            case .failure(let error):
                print("Failed to update note: \(error)")
            }
        }
    }
    
    func setupConstraints() {
        
        titleNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
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
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(noteTextView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        editNoteButton.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
    }
    
}

extension NoteDetailController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return note?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! NotePhotoCollectionViewCell
        
        if let url = URL(string: note?.images[indexPath.item].image_link ?? "") {
            cell.imageView.sd_setImage(with: url)
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
