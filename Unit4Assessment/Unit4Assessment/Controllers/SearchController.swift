//
//  SearchController.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchController: UIViewController {

    // MARK: Properties
    private var searchCardsView = SearchCardsView()
    public var dataPersistence: DataPersistence<FlashCard>!
    
    private var flashcards = [FlashCard](){
        didSet{
            DispatchQueue.main.async{
                self.searchCardsView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView(){
        view = searchCardsView
    }
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search Flashcards"
        setUp()
    }
    
    // MARK: Helper Methods
    private func setUp(){
        // Set delegate and datasource on collectionView
        searchCardsView.collectionView.dataSource = self
        searchCardsView.collectionView.delegate = self
        
        // Register Cell
        searchCardsView.collectionView.register(APIFlashCardCell.self, forCellWithReuseIdentifier: "apiCell")
        
        // Populate CollectionView
        flashcards = FlashcardAPI.getFlashcardsLocally()
    }

}

// MARK: CollectionViewDataSource Methods
extension SearchController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flashcards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let xCell = collectionView.dequeueReusableCell(withReuseIdentifier: "apiCell", for: indexPath) as? APIFlashCardCell else {
            fatalError("Could not dequeue cell as an APIFlashCardCell")
        }
        xCell.configureCell(flashcards[indexPath.row])
        xCell.backgroundColor = .systemGray4
        xCell.delegate = self
        return xCell
    }
}

// MARK: CollectionViewDelegate Methods
extension SearchController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

// MARK: APIFlashCardCellDelegate Methods
extension SearchController: APIFlashCardCellDelegate{
    func addButtonPressed(_ apiCell: APIFlashCardCell) {
        if !dataPersistence.hasItemBeenSaved(apiCell.currentCard){
            do {
                try dataPersistence.createItem(apiCell.currentCard)
                showAlert("Flash card Saved", "Flash card: \"\(apiCell.questionLabel.text!)\" was added to your saved cards.")
            } catch {
                showAlert("Error saving API FlashCard", "\(error)")
            }
        } else {
            showAlert("Hmm...", "It would seem this flashcard is already saved in your archive")
        }
    }
}
