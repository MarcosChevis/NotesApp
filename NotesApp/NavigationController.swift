//
//  NavigationController.swift
//  NotesApp
//
//  Created by Caroline Taus on 21/01/22.
//

import Foundation
import UIKit

class NavigationController : UINavigationController {
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        if let topVC = viewControllers.last {
             //return the status property of each VC, look at step 2
             return topVC.preferredStatusBarStyle
         }
        
        return .default
    }
}
