//
//  AddNewCardView.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class AddNewCardView: UIView {

    // MARK: Properties
    public lazy var leftBarButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Clear"
        return bbi
    }()
    
    public lazy var rightBarButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Create"
        return bbi
    }()
    
    public lazy var textField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "  Insert Title here"
        tf.backgroundColor = .systemBackground
        return tf
    }()
    
    public lazy var upperTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Enter a fact here"
        tv.font = UIFont(name: "Avenir", size: 17)
        return tv
    }()
    
    public lazy var lowerTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Enter a fact here"
        tv.font = UIFont(name: "Avenir", size: 17)
        return tv
    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpTextFieldConstraints()
        setUpUpperTextViewConstraints()
        setUpLowerTextViewConstraints()
    }
    
    // MARK: Constraint Setup Methods
    private func setUpTextFieldConstraints(){
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20), textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), textField.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setUpUpperTextViewConstraints(){
        addSubview(upperTextView)
        upperTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([upperTextView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20), upperTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), upperTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), upperTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3) ])
    }
    
    private func setUpLowerTextViewConstraints(){
        addSubview(lowerTextView)
        lowerTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lowerTextView.topAnchor.constraint(equalTo: upperTextView.bottomAnchor, constant: 20), lowerTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20), lowerTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20), lowerTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)])
    }


}
