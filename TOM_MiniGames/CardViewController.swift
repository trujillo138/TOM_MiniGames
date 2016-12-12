//
//  CardViewController.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    //MARK: Properties
    
    /** Collection of cards that will be displayed */
    var cards: [Card]?
    
    //MARK: Outlets
    
    @IBOutlet var cardViews: [CardView]!
    
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
    
    //MARK: Initialization Methods
    
    private func startGame() {
        var cardValues = [1, 1, 2, 2, 3, 3, 4, 4]
        for cardView in cardViews {
            let randomCardValueIndex = arc4random_uniform(UInt32(cardValues.count))
            let cardValue = cardValues.remove(at: Int(randomCardValueIndex))
            let card = Card(cardValue: cardValue, flipped: false, paired: false)
            cardView.card = card
        }
    }
    
}
