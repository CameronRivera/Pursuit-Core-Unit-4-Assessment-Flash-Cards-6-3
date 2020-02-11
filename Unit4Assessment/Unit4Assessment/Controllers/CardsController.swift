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

    // MARK: Properties
    private var flashCardsView = FlashCardsView()
    private var flashcardArr: [FlashCard] = []{
        didSet{
            flashCardsView.collectionView.reloadData()
            if flashcardArr.isEmpty{
                flashCardsView.collectionView.backgroundView = EmptyStateView(title: "There are currently no cards saved in your archive", message: "Head over to the search tab to add some ready made ones, or check out the create tab to create your own.")
            } else {
                flashCardsView.collectionView.backgroundView = nil
            }
        }
    }
    public var dataPersistence: DataPersistence<FlashCard>!
    
    override func loadView() {
        view = flashCardsView
    }
    
    // MARK: Lifecycle Methods
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
    
    // MARK: Helper Methods
    private func setUp(){
        // Set DataSource and Delegate
        flashCardsView.collectionView.dataSource = self
        flashCardsView.collectionView.delegate = self
        
        // Register Cell
        flashCardsView.collectionView.register(FlashCardCell.self, forCellWithReuseIdentifier: "flashCardCell")
        
        // Set searchBar delegate
        flashCardsView.searchBar.delegate = self
    }

}

// MARK: UICollectionViewDataSource Methods
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

// MARK: UICollectionViewDelegate Methods
extension CardsController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

// MARK: SearchBar Delegate Methods
extension CardsController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        do {
            if searchText == ""{
                flashcardArr = try dataPersistence.loadItems()
            } else {
                flashcardArr = try dataPersistence.loadItems().filter{$0.quizTitle.lowercased().contains(searchText.lowercased())}
            }
        } catch {
            print("Error loading cards: \(error)")
        }
    }
}

// MARK: FlashCardCellDelegate Methods
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
