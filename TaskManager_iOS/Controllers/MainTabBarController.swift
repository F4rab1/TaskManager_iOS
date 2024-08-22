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

        if index == 2 {
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
        
        fetchAndStoreCategories()
        
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    func fetchAndStoreCategories() {
        APIService.shared.fetchAndStoreCategories { error in
            if let error = error {
                print("Failed to fetch categories: \(error.localizedDescription)")
            } else {
                print("Categories fetched and stored successfully")
            }
        }
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
        let homeNavController = createNavController(viewController: HomeController(), title: "Home", imageName: "house.fill", size: 1.5)
        let calendarNavController = createNavController(viewController: CalendarController(), title: "Calendar", imageName: "calendar", size: 1.5)
        let addNavController = createNavController(viewController: AddController(), title: "", imageName: "plus.circle.fill", size: 2.5)
        let notesNavController = createNavController(viewController: NotesController(), title: "Notes", imageName: "square.text.square", size: 1.5)
        let profileNavController = createNavController(viewController: ProfileController(), title: "Profile", imageName: "person.fill", size: 1.5)
        
        viewControllers = [homeNavController,
                           calendarNavController,
                           addNavController,
                           notesNavController,
                           profileNavController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String, size: Float) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = UIColor(red: 249, green: 252, blue: 254)
        navController.tabBarItem.title = title
        if let image = UIImage(systemName: imageName) {
            let resizedImage = image.resize(to: CGSize(width: image.size.width * CGFloat(size), height: image.size.height * CGFloat(size)))
            navController.tabBarItem.image = resizedImage
        }
        return navController
    }
    
}

extension UIImage {
    func resize(to targetSize: CGSize) -> UIImage? {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what the aspect ratio should be
        let newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // Create a new rectangle to fit the resized image
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Resize the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

