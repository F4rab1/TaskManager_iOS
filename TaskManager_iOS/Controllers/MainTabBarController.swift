//
//  ViewController.swift
//  TaskManager_iOS
//
//  Created by Фараби Иса on 24.07.2024.
//

import UIKit

class BaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)

        if index == 1 {
            let controller = AddController()
            let navController = UINavigationController(rootViewController: controller)
            present(navController, animated: true, completion: nil)
    
            return false
        }
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    func setupTabBarAppearance() {
        let selectedColor = UIColor(red: 16, green: 94, blue: 245)
        let unselectedColor = UIColor.black
        
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([.foregroundColor: unselectedColor], for: .normal)
        appearance.setTitleTextAttributes([.foregroundColor: selectedColor], for: .selected)
        
        tabBar.tintColor = selectedColor
        tabBar.unselectedItemTintColor = unselectedColor
        tabBar.backgroundColor = .white
        
        let borderLayer = CALayer()
        borderLayer.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 1)
        borderLayer.backgroundColor = UIColor(red: 234, green: 235, blue: 236).cgColor
        tabBar.layer.addSublayer(borderLayer)
    }
    
    func setupViewControllers() {
        let homeNavController = createNavController(viewController: HomeController(), title: "Home", imageName: "home")
        let addNavController = createNavController(viewController: AddController(), title: "", imageName: "plus 2")
        let calendarNavController = createNavController(viewController: CalendarController(), title: "Calendar", imageName: "calendar")
        
        viewControllers = [homeNavController,
                           addNavController,
                           calendarNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
}

