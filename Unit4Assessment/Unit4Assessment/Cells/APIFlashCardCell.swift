//
//  APIFlashCardCell.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol APIFlashCardCellDelegate: AnyObject{
    func addButtonPressed(_ apiCell: APIFlashCardCell)
}

class APIFlashCardCell: UICollectionViewCell {
    
    public weak var delegate: APIFlashCardCellDelegate?
    public var currentCard: FlashCard!
    private var isTextViewShowing = false
    
    public lazy var addButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        button.alpha = 1.0
        return button
    }()
    
    public lazy var questionLabel: UILabel = {
       let label = UILabel()
        label.text = "I am the text of a label that works"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.alpha = 1.0
        return label
    }()
    
    public lazy var factsView: UITextView = {
       let tv = UITextView()
        tv.isUserInteractionEnabled = false
        tv.isEditable = false
        tv.alpha = 0.0
        return tv
    }()
    
    public lazy var longPress: UILongPressGestureRecognizer = {
        let lp = UILongPressGestureRecognizer()
        lp.addTarget(self, action: #selector(longPressEngaged(_:)))
        return lp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpAddButtonConstraints()
        setUpQuestionLabelConstraints()
        setUpFactsViewConstraints()
        addGestureRecognizer(longPress)
    }
    
    private func setUpAddButtonConstraints(){
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8), addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), addButton.heightAnchor.constraint(equalToConstant: 44), addButton.widthAnchor.constraint(equalToConstant: 44)])
    }
    
    private func setUpQuestionLabelConstraints(){
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([questionLabel.centerYAnchor.constraint(equalTo: centerYAnchor), questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)])
    }
    
    private func setUpFactsViewConstraints(){
        addSubview(factsView)
        factsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([factsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), factsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), factsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), factsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
    }
    
    @objc
    private func addButtonPressed(_ sender: UIButton) {
        delegate?.addButtonPressed(self)
    }
    
    @objc
    private func longPressEngaged(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        turnTheCardAround()
    }
    
    private func turnTheCardAround(){
        if isTextViewShowing{
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromTop], animations: {
                self.addButton.alpha = 1.0
                self.questionLabel.alpha = 1.0
                self.factsView.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromBottom], animations: {
                self.addButton.alpha = 0.0
                self.questionLabel.alpha = 0.0
                self.factsView.alpha = 1.0
            }, completion: nil)
        }
        isTextViewShowing.toggle()
    }
    
    public func configureCell(_ card: FlashCard){
        questionLabel.text = card.quizTitle
        factsView.text = card.facts.reduce("", { (result, string) -> String in
            if result == ""{
                return result + string
            }
            return result + " " + string
        })
        currentCard = card
    }

}
