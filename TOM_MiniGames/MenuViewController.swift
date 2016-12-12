//
//  MenuViewController.swift
//  TOM_MiniGames
//
//  Created by Tomas Trujillo on 7/16/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

enum MenuOptions:Int {
    case cardController = 1
    case iconController = 2
    case aboutController = 3
    case creditsController = 4
}

class MenuViewController: UIViewController {
    
    //MARK: Outlets
    
    /** Constraint that will make the menu stay to the left of the view, out of the user's sight */
    @IBOutlet fileprivate weak var hidingMenuConstraint: NSLayoutConstraint!
    /** Constraint that will make the menu show completely on the screen */
    @IBOutlet fileprivate weak var showingMenuContraint: NSLayoutConstraint!

    fileprivate var showing = false
    
    fileprivate var presentingController: UIViewController?
    
    fileprivate var previouslySelectedPosition = -1
    
    @IBOutlet fileprivate weak var menuView: UIView!
    
    //MARK: Properties

    fileprivate struct MenuConstants {
        static let CardStoryBoardIdentifier = "CardStoryboard"
        static let IconStoryBoardIdentifier = "IconStoryboard"
        static let AboutStoryBoardIdentifier = "AboutStoryboard"
        static let CreditsStoryBoardIdentifier = "CreditsStoryboard"
        static let CardViewControllerIdentifier = "CardViewController"
        static let IconViewControllerIdentifier = "IconViewController"
        static let AboutViewControllerIdentifier = "AboutViewController"
        static let CreditsViewControllerIdentifier = "CreditsViewController"
        static let CardViewControllerPosition = 1
        static let IconViewControllerPosition = 2
        static let AboutViewControllerPosition = 3
        static let CreditsViewControllerPosition = 4
    }
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCardsController(self)
    }
    
    //MARK: Animations
    
    private func slideMenuToTheLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.showingMenuContraint.isActive = false
            self.hidingMenuConstraint.isActive = true
            self.view.layoutIfNeeded()
        }) 
    }
    
    private func loadControllerSelectedAtPosistion(_ position: Int) {
        guard let menuOption = MenuOptions(rawValue: position) else {
            return
        }
        if previouslySelectedPosition == position {
            slideMenuToTheLeft()
        } else {
            previouslySelectedPosition = position
            switch menuOption {
            case .cardController:
                let cardStoryBoard = UIStoryboard(name: MenuConstants.CardStoryBoardIdentifier, bundle: nil)
                presentMenuController(cardStoryBoard.instantiateViewController(withIdentifier: MenuConstants.CardViewControllerIdentifier))
            case .iconController:
                let iconStoryBoard = UIStoryboard(name: MenuConstants.IconStoryBoardIdentifier, bundle: nil)
                presentMenuController(iconStoryBoard.instantiateViewController(withIdentifier: MenuConstants.IconViewControllerIdentifier))
            case .aboutController:
                let aboutStoryBoard = UIStoryboard(name: MenuConstants.AboutStoryBoardIdentifier, bundle: nil)
                presentMenuController(aboutStoryBoard.instantiateViewController(withIdentifier: MenuConstants.AboutViewControllerIdentifier))
            case .creditsController:
                let creditsStoryBoard = UIStoryboard(name: MenuConstants.CreditsStoryBoardIdentifier, bundle: nil)
                presentMenuController(creditsStoryBoard.instantiateViewController(withIdentifier: MenuConstants.CreditsViewControllerIdentifier))
            }
        }
    }
    
    fileprivate func presentMenuController(_ controllerToPresent: UIViewController?) {
        guard let controller = controllerToPresent else {
            return
        }
        let previousPresentedController = presentingController
        presentingController = controller
        addNewMenuSelectionToView(controller.view)
        previousPresentedController?.view.removeFromSuperview()
    }
    
    fileprivate func addNewMenuSelectionToView(_ viewToAdd: UIView) {
        var outSideFrame = viewToAdd.frame
        outSideFrame.origin = CGPoint(x: -view.bounds.width, y: 0.0)
        viewToAdd.frame = outSideFrame
        UIView.animate(withDuration: 0.3, animations: {
            viewToAdd.frame = self.view.bounds
            self.view.insertSubview(viewToAdd, belowSubview: self.menuView)
            self.slideMenuToTheLeft()
        })
    }
    
    //MARK: Actions
    
    @IBAction func openMenu(_ sender: AnyObject) {
        if (showing) {
            closeMenu(sender)
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.hidingMenuConstraint.isActive = false
                self.showingMenuContraint.isActive = true
                self.view.layoutIfNeeded()
            })
        }
        showing = !showing
    }
    
    @IBAction func closeMenu(_ sender: AnyObject) {
        slideMenuToTheLeft()
    }
    
    @IBAction func loadCardsController(_ sender: AnyObject) {
        loadControllerSelectedAtPosistion(MenuConstants.CardViewControllerPosition)
    }
    
    @IBAction func loadIconController(_ sender: AnyObject) {
        loadControllerSelectedAtPosistion(MenuConstants.IconViewControllerPosition)
    }
    
    @IBAction func loadAboutController(_ sender: AnyObject) {
        loadControllerSelectedAtPosistion(MenuConstants.AboutViewControllerPosition)
    }
    
    @IBAction func loadCreditsController(_ sender: AnyObject) {
        loadControllerSelectedAtPosistion(MenuConstants.CreditsViewControllerPosition)
    }

}
