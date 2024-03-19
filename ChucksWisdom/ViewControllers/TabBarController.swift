//
//  TabBarController.swift
//  ChucksWisdom
//
//  Created by Apple Mac Air on 15.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private var downloadNavigationController: UINavigationController!
    private var listNavigationController: UINavigationController!
      private var categoryNavigationController: UINavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        tabBarSetup()
    }

    private func tabBarSetup() {

        downloadNavigationController = UINavigationController.init(rootViewController: DownloadViewController())
        listNavigationController = UINavigationController.init(rootViewController: ListViewController())
        categoryNavigationController = UINavigationController.init(rootViewController: CategoryViewController())

        self.viewControllers = [downloadNavigationController,listNavigationController, categoryNavigationController]

        downloadNavigationController.tabBarItem = UITabBarItem(title: "Загрузить", image: UIImage(systemName: "square.and.arrow.down"), tag: 0)
        listNavigationController.tabBarItem = UITabBarItem(title: "Список цитат", image: UIImage(systemName: "list.bullet.clipboard"), tag: 1)
            categoryNavigationController.tabBarItem = UITabBarItem(title: "Категории", image: UIImage(systemName: "folder"), tag: 2)

        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().backgroundColor = .systemGray6
    }
}
