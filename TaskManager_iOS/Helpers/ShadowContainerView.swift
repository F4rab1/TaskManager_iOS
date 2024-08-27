//
//  ShadowContainerView.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 27.08.2024.
//

import UIKit

class ShadowContainerView: UIView {
    
    init(cornerRadius: CGFloat = 10, shadowColor: UIColor = .black, shadowOpacity: Float = 0.1, shadowRadius: CGFloat = 2, shadowOffset: CGSize = CGSize(width: 0, height: 4)) {
        super.init(frame: .zero)
        setupShadow(cornerRadius: cornerRadius, shadowColor: shadowColor, shadowOpacity: shadowOpacity, shadowRadius: shadowRadius, shadowOffset: shadowOffset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupShadow(cornerRadius: CGFloat, shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize) {
        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
