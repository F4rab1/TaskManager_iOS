//
//  UIView+Extensions.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 02.11.2024.
//

import UIKit

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
