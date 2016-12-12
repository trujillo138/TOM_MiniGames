//
//  AboutViewController.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet private weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rotateView(360)
    }
    
    private func rotateView(_ angle: CGFloat) {
        UIView.animate(withDuration: 0.15, animations: { 
            self.aboutTextView.transform = self.aboutTextView.transform.concatenating(CGAffineTransform(rotationAngle: angle / 2 / 180.0 * CGFloat(M_PI)))
            }, completion: { _ in
                UIView.animate(withDuration: 0.15, animations: { 
                    self.aboutTextView.transform = self.aboutTextView.transform.concatenating(CGAffineTransform(rotationAngle: angle / 2 / 180.0 * CGFloat(M_PI)))
                })
        }) 
        
    }
}
