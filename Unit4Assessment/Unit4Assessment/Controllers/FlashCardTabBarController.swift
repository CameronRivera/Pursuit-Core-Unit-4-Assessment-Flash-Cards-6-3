//
//  FlashCardTabBarController.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardTabBarController: UITabBarController {

    // MARK: Properties
    private var dataPersistence = DataPersistence<FlashCard>(filename: "savedFlashcards.plist")
    
    public lazy var FlashCardsController: CardsController = {
        let vc = CardsController()
        vc.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName:"archivebox.fill"), tag: 1)
        vc.dataPersistence = dataPersistence
        return vc
    }()
    
    public lazy var CreateFlashCardsController: CreateController = {
        let vc = CreateController()
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 2)
        vc.dataPersistence = dataPersistence
        return vc
    }()
    
    public lazy var SearchOnlineController: SearchController = {
        let vc = SearchController()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        vc.dataPersistence = dataPersistence
        return vc
    }()
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: FlashCardsController), UINavigationController(rootViewController: CreateFlashCardsController), UINavigationController(rootViewController: SearchOnlineController)]
    }

}
