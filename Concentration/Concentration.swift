//
//  Concentration.swift
//  Concentration
//
//  Created by Lee Cooper on 5/12/18.
//  Copyright © 2018 Lee Cooper. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            // card hasn't been matched already
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // this is the second card being flipped
                if cards[matchIndex].identifier == cards[index].identifier {
                    // the 2 cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    // 2 cards do not match so penalize score for already seen cards
                    if cards[index].previouslySeen {
                        score -= 1
                    }
                    if cards[matchIndex].previouslySeen {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                cards[index].previouslySeen = true
                cards[matchIndex].previouslySeen = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        for card in 0..<(cards.count) {
            cards.swapAt(card, Int(arc4random_uniform(UInt32(cards.count))))
        }
    }
}
