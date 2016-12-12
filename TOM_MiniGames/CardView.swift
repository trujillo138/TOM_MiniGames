//
//  CardView.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    //MARK: Properties
    
    var card: Card? {
        didSet {
            self.updateCardView()
        }
    }
    
    //MARK: Drawing functions

    /** Updates the cardView's colors and subviews */
    private func updateCardView() {
        guard let thisCard = card else {
            return
        }
        DispatchQueue.main.async {
            self.backgroundColor = thisCard.flipped ? self.colorForNumber(thisCard.cardValue) : UIColor.black
        }
    }
    
    private func createRoundedRectCorners() {
        layer.cornerRadius = bounds.width * 0.01
    }
    
    private func colorForNumber(_ number: Int) -> UIColor {
        if number == 1 {
            return UIColor.red
        } else if number == 2 {
            return UIColor.blue
        } else if number == 3 {
            return UIColor.yellow
        } else {
            return UIColor.orange
        }
    }
    
    //MARK: Gestures
    
    /** Function that will be called each time the user taps the view. This will change the flipped state from the card */
    func tappedCard(_ tapGesture: UITapGestureRecognizer) {
        UIView.transition(with: self, duration: 0.4, options: .transitionFlipFromLeft, animations: {
            self.card?.flipCard()
            }, completion: nil)
    }
    
    
    //MARK: Setup
    
    /** Sets up the properties of a card view */
    private func setup() {
        isOpaque = false
        contentMode = .redraw
        createRoundedRectCorners()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedCard(_:))))
        updateCardView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
}
