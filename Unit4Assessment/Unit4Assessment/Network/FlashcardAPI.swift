//
//  FlashcardAPI.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct FlashcardAPI{
    // Retrive Flashcards from the endPoint provided
    static func getFlashcards(completion: @escaping (Result<[FlashCard],AppError>) -> ()){
        let endpointString = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
        
        guard let url = URL(string: endpointString) else {
            completion(.failure(.badURL(endpointString)))
            return
        }
        
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
                    completion(.success(wrapper.cards))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    // Retrieve Flashcards from local json data.
    static func getFlashcardsLocally() -> [FlashCard]{
        var cards: [FlashCard] = []
        guard let path = Bundle.main.path(forResource: "FlashCardData", ofType: "json") else {
            print("Could not obtain path to resource")
            return cards
        }
        
        guard let data = FileManager.default.contents(atPath: path) else {
            print("Could not obtain data at file path")
            return cards
        }
        
        do {
            cards = try JSONDecoder().decode([FlashCard].self, from: data)
        } catch {
            print("Error: \(error)")
        }
        return cards
    }
}
