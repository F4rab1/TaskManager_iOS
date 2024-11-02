//
//  NoteTableViewCell.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 11.08.2024.
//

import UIKit
import SnapKit

class NoteTableViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var note: Note? {
        didSet {
            titleLabel.text = note?.title
            textOfNoteLabel.text = note?.text
        }
    }
    
    var selectedImage: UIImage?
    weak var collectionView: UICollectionView?
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 237, green: 242, blue: 246)
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(red: 211, green: 211, blue: 211).cgColor
        view.layer.borderWidth = 0.5
        view.layer.masksToBounds = true
        return view
    }()
 
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Title"
        return label
    }()
    
    let textOfNoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Text"
        label.numberOfLines = 2
        return label
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        
        contentView.addSubview(shadowContainerView)
        shadowContainerView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(textOfNoteLabel)
        containerView.addSubview(photoCollectionView)
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(NotePhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        photoCollectionView.register(PlusButtonCollectionViewCell.self, forCellWithReuseIdentifier: "PlusCell")
    }
    
    func setupConstraints() {
        shadowContainerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(shadowContainerView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(containerView).inset(16)
        }
        
        textOfNoteLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(containerView).inset(16)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(textOfNoteLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(containerView).inset(16)
            make.height.equalTo(100)
            make.bottom.equalTo(containerView).inset(10)
        }
    }
    
}

extension NoteTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (note?.images.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlusCell", for: indexPath) as! PlusButtonCollectionViewCell
            cell.plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! NotePhotoCollectionViewCell
            
            if let image = selectedImage, indexPath.item == 1 {
                cell.imageView.image = image
            } else if let url = URL(string: note?.images[indexPath.item - 1].image_link ?? "") {
                cell.imageView.sd_setImage(with: url)
            }
            
            return cell
        }
    }
    
    @objc func didTapPlusButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        if let viewController = findViewController() {
            viewController.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            
            guard let selectedImage = selectedImage else { return }
            let noteID = (note?.id)!
            
            APIServiceNotes.shared.uploadImage(noteID: noteID, image: selectedImage) { (success, error) in
                if let error = error {
                    print("Error uploading image:", error)
                } else {
                    print("Image uploaded successfully")
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageURLString = note?.images[indexPath.item - 1].image_link,
              let imageURL = URL(string: imageURLString) else { return }
        
        let fullscreenVC = FullscreenImageViewController()
        fullscreenVC.imageURL = imageURL
        if let viewController = self.findViewController() {
            viewController.navigationController?.pushViewController(fullscreenVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
