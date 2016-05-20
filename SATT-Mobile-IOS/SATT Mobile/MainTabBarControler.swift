//
//  MainTabBarControler.swift
//  SATT Mobile
//
//  Created by Daniel Soto rey on 17/05/16.
//  Copyright © 2016 Daniel Soto Rey. All rights reserved.
//

import UIKit
import SWRevealViewController

class MainTabBarControler: UITabBarController {

    @IBOutlet weak var menuB: UIBarButtonItem!

    var presentedController: SATTController?
    
    override func viewDidLoad() {
        
        menuB.target = self.revealViewController()
        menuB.action = "revealToggle:"
        
        self.presentedController = self.selectedViewController as? SATTController
        self.presentedController = self.viewControllers![0] as? SATTController
    }
    
    override func viewDidAppear(animated: Bool) {
        if (SATT.sessionManager.currentUser == nil){
            let login : LoginViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("login") as? LoginViewController)!
            self.presentViewController(login, animated: true, completion: {login.loadParent(self)})
        }
    }
    
    func loadController(){
        presentedController?.loadContent()
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController){
        self.presentedController = self.viewControllers![self.selectedIndex] as? SATTController
    }

}

protocol SATTController{
    func loadContent()
}

