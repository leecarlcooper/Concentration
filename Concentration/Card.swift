//
//  Card.swift
//  Concentration
//
//  Created by Lee Cooper on 5/12/18.
//  Copyright © 2018 Lee Cooper. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var previouslySeen = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
