//
//  FlashCard.swift
//  Unit4Assessment
//
//  Created by Cameron Rivera on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct Wrapper: Codable{
    let cards: [FlashCard]
}

struct FlashCard: Codable, Equatable{
    let id: String
    let quizTitle: String
    let facts: [String]
}
