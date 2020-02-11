//
//  EmptyStateView.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {

    // MARK: Properties
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    public lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 4
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()

    // MARK: Initializers
    init(title: String, message: String){
        super.init(frame: UIScreen.main.bounds)
        titleLabel.text = title
        messageLabel.text = message
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpMessageLabelConstraints()
        setUpTitleLabelConstraints()
    }
    
    // MARK: Constraint Setup Methods
    private func setUpMessageLabelConstraints(){
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor), messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8), messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
    }
    
    private func setUpTitleLabelConstraints(){
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8), titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8), titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
    }

}
