//
//  FullscreenImageViewController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 27.10.2024.
//

import UIKit
import SnapKit

class FullscreenImageViewController: UIViewController {
    
    var imageURL: URL? {
        didSet {
            if let url = imageURL {
                imageView.sd_setImage(with: url)
            }
        }
    }
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
