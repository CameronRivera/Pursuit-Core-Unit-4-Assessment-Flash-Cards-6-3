//
//  FlashCardCell.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol FlashCardCellDelegate: AnyObject{
    func optionsButtonPressed(_ cardCell: FlashCardCell)
}

class FlashCardCell: UICollectionViewCell {
    
    public weak var delegate: FlashCardCellDelegate?
    public var myIndex: Int = -1
    
    public lazy var optionsButton: UIButton = {
       let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        button.alpha = 1.0
        return button
    }()
    
    public lazy var questionLabel: UILabel = {
       let label = UILabel()
        label.alpha = 1.0
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "I am a purple Label who lived in a time when there were no other purple labels. As such, I was the first of my kind."
        label.backgroundColor = .orange
        return label
    }()
    // CONSIDER CHANGING THIS TO SOMETHING THAT IS NOT A TEXT VIEW.
    public lazy var factsView: UITextView = {
       let tv = UITextView()
        tv.alpha = 0.0
        tv.text = "I am textView. I live for the single purpose of displaying text in large quantities to the screen. It may seem like a thankless and boring job, but I am quite content with it. In fact, it would not be so ridiculous to say that I love it."
        tv.backgroundColor = UIColor.cyan
        return tv
    }()
    
    public lazy var longPress: UILongPressGestureRecognizer = {
        let lp = UILongPressGestureRecognizer()
        lp.addTarget(self, action: #selector(longPressHappened))
        return lp
    }()
    
    private var textFieldIsShowing = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setUpOptionsButtonConstraints()
        setUpQuestionLabelConstraints()
        setUpFactsViewConstraints()
        factsView.isUserInteractionEnabled = false
        factsView.isEditable = false
        addGestureRecognizer(longPress)
    }
    
    private func setUpOptionsButtonConstraints(){
        addSubview(optionsButton)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([optionsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), optionsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), optionsButton.heightAnchor.constraint(equalToConstant: 44), optionsButton.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    private func setUpQuestionLabelConstraints(){
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)])
    }
    
    private func setUpFactsViewConstraints(){
        addSubview(factsView)
        factsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([factsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8), factsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8), factsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8), factsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)])
    }
    
    @objc
    private func buttonPressed(_ sender: UIButton){
        delegate?.optionsButtonPressed(self)
    }
    
    @objc
    private func longPressHappened(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began || gesture.state == .changed {
            return
        }
       // Populate textField
        flipItOver()
    }
    
    private func flipItOver(){
        if textFieldIsShowing {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromTop], animations: {
                self.questionLabel.alpha = 1.0
                self.optionsButton.alpha = 1.0
                self.factsView.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 1.0, options: [.transitionFlipFromBottom], animations: {
                self.questionLabel.alpha = 0.0
                self.optionsButton.alpha = 0.0
                self.factsView.alpha = 1.0
            }, completion: nil)
        }
        textFieldIsShowing.toggle()
    }
    
    public func configureCell(_ card: FlashCard, _ index: Int){
        myIndex = index
        questionLabel.text = card.quizTitle
        factsView.text = card.facts.reduce("", { (result, string) -> String in
            if result == ""{
                return result + string
            }
            return result + " " + string
        })
    }

}
