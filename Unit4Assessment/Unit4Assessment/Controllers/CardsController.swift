//
//  CreateCardsController.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CardsController: UIViewController {

    private var flashCardsView = FlashCardsView()
    private var flashcardArr: [FlashCard] = []{
        didSet{
            flashCardsView.collectionView.reloadData()
        }
    }
    public var dataPersistence: DataPersistence<FlashCard>!
    
    override func loadView() {
        view = flashCardsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Flash Cards"
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        do{
            flashcardArr = try dataPersistence.loadItems()
        } catch {
            print("Error loading persisted data: \(error)")
        }
    }
    
    private func setUp(){
        // Set DataSource and Delegate
        flashCardsView.collectionView.dataSource = self
        flashCardsView.collectionView.delegate = self
        
        // Register Cell
        flashCardsView.collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: "flashCardCell")
    }

}

extension CardsController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashcardArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "flashCardCell", for: indexPath) as? FlashCardCell else {
            fatalError("Could not dequeue Cell as a FlashCardCell")
        }
        xCell.backgroundColor = .cyan
        xCell.delegate = self
        xCell.configureCell(flashcardArr[indexPath.row], indexPath.row)
        return xCell
    }
}

extension CardsController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension CardsController: FlashCardCellDelegate{
    func optionsButtonPressed(_ cardCell: FlashCardCell) {
        let alertController = UIAlertController(title: "What would you like to do?", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            do {
                try self?.dataPersistence.deleteItem(at: cardCell.myIndex)
                self?.flashcardArr.remove(at: cardCell.myIndex)
            } catch {
                print("Error removing item from saved items: \(error)")
            }
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
