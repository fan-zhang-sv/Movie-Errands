//
//  TabBarViewController.swift
//  Movie Errands
//
//  Created by Fan Zhang on 6/13/20.
//  Copyright © 2020 Fan Zhang. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor(named: "movieOrrange")

        let layout = UICollectionViewFlowLayout()
        let movieErrandsViewController = UINavigationController(rootViewController: MoviesViewController(collectionViewLayout: layout))
                
        movieErrandsViewController.tabBarItem = UITabBarItem(title: "Movie Errands", image: UIImage(systemName: "tv.fill"), tag: 0)

        let searchViewController = UINavigationController(rootViewController: SearchViewController())

        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        let tabBarList = [movieErrandsViewController, searchViewController]

        viewControllers = tabBarList
    }
}
