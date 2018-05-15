//
//  ViewController.swift
//  Concentration
//
//  Created by Lee Cooper on 5/11/18.
//  Copyright © 2018 Lee Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        selectRandomEmojis()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card) , for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    // MARK: emoji code
    let emojiThemes = ["Halloween":["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎","🌕"],
                       "Animals":["🦓","🦒","🦑","🐸","🐒","🦄","🦁","🐷","🐔","🐊"],
                       "Sports":["⚽️","🏈","🏀","⚾️","🏏","🏄‍♂️","🥊","⛳️","🧘‍♂️","🏹"],
                       "Faces":["😎","🤓","🙂","😡","🤪","😢","🙄","😴","🤡","👽"],
                       "Food":["🍕","🍔","🥥","🌽","🥨","🍇","🥕","🥦","🥑","🥩"],
                       "Travel":["✈️","🚂","🛴","🚲","🚠","🚕","🚁","⛴","🎢","🛸"]]
    
    lazy var emojiChoices = Array(emojiThemes.values)[0]
 
    func selectRandomEmojis() {
        let index: Int = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        emojiChoices = Array(emojiThemes.values)[index]
    }
    
    var emoji = [Int:String]()

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
