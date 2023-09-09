//
//  TabBarViewController.swift
//  Spotify
//
//  Created by LE BA TRONG on 28/01/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vcHome = HomeViewController()
        let vcSearch = SearchViewController()
        let vcLibrary = LibraryViewController()
        
        vcHome.title = "Browser"
        vcSearch.title = "Search"
        vcLibrary.title = "Library"
        
        vcHome.navigationItem.largeTitleDisplayMode = .always
        vcSearch.navigationItem.largeTitleDisplayMode = .always
        vcLibrary.navigationItem.largeTitleDisplayMode = .always
        
        let navHome = UINavigationController(rootViewController: vcHome)
        let navLibrary = UINavigationController(rootViewController: vcLibrary)
        let navSearch = UINavigationController(rootViewController: vcSearch)
        
        navHome.navigationBar.tintColor = .label
        navSearch.navigationBar.tintColor = .label
        navLibrary.navigationBar.tintColor = .label
        
        navHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        navSearch.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        navLibrary.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        navHome.navigationBar.prefersLargeTitles = true
        navLibrary.navigationBar.prefersLargeTitles = true
        navSearch.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navHome,navSearch,navLibrary], animated: false)
    }
    

}
