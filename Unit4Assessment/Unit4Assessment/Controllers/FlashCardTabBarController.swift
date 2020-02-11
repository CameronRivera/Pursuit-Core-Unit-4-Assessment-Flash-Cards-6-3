//
//  FlashCardTabBarController.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class FlashCardTabBarController: UITabBarController {

    public lazy var FlashCardsController: UIViewController = {
        let vc = CardsController()
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName:"archivebox.fill"), tag: 1)
        return vc
    }()
    
    public lazy var CreateFlashCardsController: UIViewController = {
        let vc = CreateController()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)
        return vc
    }()
    
    public lazy var SearchOnlineController: UIViewController = {
        let vc = SearchController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: FlashCardsController), UINavigationController(rootViewController: CreateFlashCardsController), UINavigationController(rootViewController: SearchOnlineController)]
    }

}
