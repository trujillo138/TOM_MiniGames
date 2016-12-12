//
//  CreditsViewController.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet private var creditLabels: [UILabel]!
    
    //MARK: Variables
    
    private var originalPositions = [CGPoint]()
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for label in creditLabels {
            label.alpha = 0.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        takeCreditsOutOfScreen()
        animateCreditsIntoScreen()
    }
    
    //MARK: Credits
    
    private func storeInitialPosition() {
        originalPositions = [CGPoint]()
        for label in creditLabels {
            originalPositions.append(label.frame.origin)
        }
    }
    
    private func takeCreditsOutOfScreen() {
        storeInitialPosition()
        for label in creditLabels {
            var tempFrame = label.frame
            tempFrame.origin.y += view.frame.height
            label.frame = tempFrame
        }
    }
    
    private func animateCreditsIntoScreen () {
        var delay = 0.2
        var index = 0
        for label in creditLabels {
            UIView.animate(withDuration: 0.3, delay: delay, options: .curveLinear, animations: { 
                var tempFrame = label.frame
                tempFrame.origin = self.originalPositions[index]
                label.frame = tempFrame
                label.alpha = 1.0
                }, completion: nil)
            delay += 0.2
            index += 1
        }
    }
}
