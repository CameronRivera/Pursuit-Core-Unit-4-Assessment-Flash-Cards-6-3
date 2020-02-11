//
//  FlashCardsController.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateController: UIViewController {

    private var addNewCardView = AddNewCardView()
    public var dataPersistence: DataPersistence<FlashCard>!
    private var upperTextDidChange = false
    private var lowerTextDidChange = false
    
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
        view.backgroundColor = .systemBackground
        navigationItem.title = "Create New Flash Card"
        setUp()
    }
    
    private func setUp(){
        // Add Bar Button Items
        navigationItem.rightBarButtonItem = addNewCardView.rightBarButton
        navigationItem.leftBarButtonItem = addNewCardView.leftBarButton
        
        // Set Delegates
        addNewCardView.textField.delegate = self
        addNewCardView.upperTextView.delegate = self
        addNewCardView.lowerTextView.delegate = self
        
        // Add targets and Actions to bar button items
        addNewCardView.leftBarButton.target = self
        addNewCardView.leftBarButton.action = #selector(clearAllFields)
        addNewCardView.rightBarButton.target = self
        addNewCardView.rightBarButton.action = #selector(persistNewCard)
    }
    
    @objc
    private func clearAllFields(){
        addNewCardView.textField.text = ""
        addNewCardView.upperTextView.text = ""
        addNewCardView.lowerTextView.text = ""
    }
    
    @objc
    private func persistNewCard(){
        if textFieldIsEmpty() && upperTextViewIsEmpty() && lowerTextViewIsEmpty() {
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.textField.layer.borderColor = UIColor.red.cgColor
            addNewCardView.upperTextView.layer.borderColor = UIColor.red.cgColor
            addNewCardView.lowerTextView.layer.borderColor = UIColor.red.cgColor
        } else if textFieldIsEmpty() && upperTextViewIsEmpty() {
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.textField.layer.borderColor = UIColor.red.cgColor
            addNewCardView.upperTextView.layer.borderColor = UIColor.red.cgColor
        } else if textFieldIsEmpty() && lowerTextViewIsEmpty() {
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.textField.layer.borderColor = UIColor.red.cgColor
            addNewCardView.lowerTextView.layer.borderColor = UIColor.red.cgColor
        } else if textFieldIsEmpty() && lowerTextViewIsEmpty() {
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.upperTextView.layer.borderColor = UIColor.red.cgColor
            addNewCardView.lowerTextView.layer.borderColor = UIColor.red.cgColor
        } else if textFieldIsEmpty(){
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.textField.layer.borderColor = UIColor.red.cgColor
        } else if upperTextViewIsEmpty() {
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.upperTextView.layer.borderColor = UIColor.red.cgColor
        } else if lowerTextViewIsEmpty() {
            showAlert("Missing Fields", "Required fields must be filled out before creating a new card.")
            addNewCardView.lowerTextView.layer.borderColor = UIColor.red.cgColor
        } else {
            // Persist Data
            //let newFlashcard = FlashCard(id: "", quizTitle: addNewCardView., facts: <#T##[String]#>)
        }
    }
    
    private func textFieldIsEmpty() -> Bool{
        return addNewCardView.textField.text == "" || addNewCardView.textField.text == " "
    }
    
    private func upperTextViewIsEmpty() -> Bool{
        return addNewCardView.upperTextView.text == "" || addNewCardView.upperTextView.text == " "
    }
    
    private func lowerTextViewIsEmpty() -> Bool{
        return addNewCardView.lowerTextView.text == "" || addNewCardView.lowerTextView.text == " "
    }
}

extension CreateController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.layer.borderColor == UIColor.red.cgColor{
            textField.layer.borderColor = UIColor.black.cgColor
        }
    }
}

extension CreateController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == addNewCardView.upperTextView && !upperTextDidChange{
            addNewCardView.upperTextView.text = ""
            upperTextDidChange = true
        } else if textView == addNewCardView.lowerTextView && !lowerTextDidChange{
            addNewCardView.lowerTextView.text = ""
            lowerTextDidChange = true
        }
        
        if textView == addNewCardView.upperTextView && addNewCardView.upperTextView.layer.borderColor == UIColor.red.cgColor{
            addNewCardView.upperTextView.layer.borderColor = UIColor.black.cgColor
        } else if textView == addNewCardView.lowerTextView && addNewCardView.lowerTextView.layer.borderColor == UIColor.red.cgColor{
            addNewCardView.lowerTextView.layer.borderColor = UIColor.black.cgColor
        }
    }
}
