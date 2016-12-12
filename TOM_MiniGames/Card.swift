//
//  Card.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

struct Card {
    
    //MARK: Properties
    
    /** Value of the card used to compare it with other cards */
    var cardValue: Int
    
    /** Determines if the card is showing its value to the user */
    var flipped = false
    
    /** Determines if this card is already paired with another card */
    var paired = false
    
    //MARK: Card Methods
    
    func isEqual(to card: Card) -> Bool {
        return cardValue == card.cardValue
    }
    
    mutating func markCardAsPaired() {
        paired = true
    }
    
    mutating func flipCard() {
        flipped = !flipped
    }
    
}