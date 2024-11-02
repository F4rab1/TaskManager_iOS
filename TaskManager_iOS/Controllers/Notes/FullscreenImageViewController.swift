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
    
    private var initialTransform: CGAffineTransform = .identity
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        imageView.addGestureRecognizer(pinchGesture)
        initialTransform = imageView.transform
    }
    
    @objc private func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        
        if gesture.state == .changed {
            view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.3) {
                view.transform = self.initialTransform
            }
        }
    }
}
