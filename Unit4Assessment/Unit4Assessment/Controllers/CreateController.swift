//
//  FlashCardsController.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateController: UIViewController {

    private var addNewCardView = AddNewCardView()
    
    override func loadView(){
        view = addNewCardView
    }
    
    override func viewWillLayoutSubviews() {
        addNewCardView.textField.layer.borderColor = UIColor.black.cgColor
        addNewCardView.textField.layer.borderWidth = 1.0
        addNewCardView.textField.layer.cornerRadius = 10.0
        addNewCardView.upperTextView.layer.borderColor = UIColor.black.cgColor
        addNewCardView.upperTextView.layer.borderWidth = 1.0
        addNewCardView.lowerTextView.layer.borderColor = UIColor.black.cgColor
        addNewCardView.lowerTextView.layer.borderWidth = 1.0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        navigationItem.title = "Create New Flash Card"
        setUp()
    }
    
    private func setUp(){
        navigationItem.rightBarButtonItem = addNewCardView.rightBarButton
        navigationItem.leftBarButtonItem = addNewCardView.leftBarButton
    }
}
