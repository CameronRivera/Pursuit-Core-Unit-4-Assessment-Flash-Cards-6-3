//
//  FlashCardsView.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class FlashCardsView: UIView {

    public lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemIndigo
        return collectionView
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
        setUpCollectionViewConstraints()
    }
    
    private func setUpCollectionViewConstraints(){
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), collectionView.leadingAnchor.constraint(equalTo: leadingAnchor), collectionView.trailingAnchor.constraint(equalTo: trailingAnchor), collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }


}
