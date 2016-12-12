//
//  IconViewController.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class IconViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet private var icons: [UIImageView]!
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIconsToPop()
    }
    
    private func addTapGesture() {
        for iconView in self.icons {
            iconView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateTapView(_:))))
            iconView.isUserInteractionEnabled = true
        }
    }
    
    //MARK: Animations
    
    private func animateIconsToPop() {
        guard let icon = icons.first else {
            return
        }
        let originalSize = icon.frame.size
        let originalPoint = icon.frame.origin
        let startingPoint = CGPoint(x: originalPoint.x + originalSize.width / 2, y: originalPoint.y + originalSize.height * 2)
        for iconView in icons {
            transformView(iconView, size: CGSize.zero, toPoint: startingPoint)
        }
        var extraDelay = 0.0
        for iconView in self.icons {
            UIView.animate(withDuration: 0.5, delay: 0.1 + extraDelay, usingSpringWithDamping: 0.5, initialSpringVelocity: 5.0, options: .curveEaseIn, animations: {
                self.transformView(iconView, size: originalSize, toPoint: originalPoint)
                iconView.alpha = 1.0
            }, completion: nil)
            extraDelay += 0.05
        }
    }
    
    private func transformView(_ view: UIView, size: CGSize, toPoint: CGPoint) {
        var frame = view.frame
        frame.size = size
        frame.origin = toPoint
        view.frame = frame
    }
    
    func animateTapView(_ tapGesture: UITapGestureRecognizer) {
        guard let view = tapGesture.view else {
            return
        }
        let scale: CGFloat = 0.2
        let originalSize = view.frame.size
        let biggerSize = CGSize(width: view.frame.width * (1.0 + scale), height: view.frame.height * (1.0 + scale))
        let originalPoint = view.frame.origin
        let upperPoint = CGPoint(x: originalPoint.x - originalSize.width * scale / 2.0, y: originalPoint.y - originalSize.height * 0.5)
        UIView.animate(withDuration: 0.3, animations: {
            self.transformView(view, size: biggerSize, toPoint: upperPoint)
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0.05, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
                    self.transformView(view, size: originalSize, toPoint: originalPoint)
                    }, completion: nil)
        }) 
    }
    

}
