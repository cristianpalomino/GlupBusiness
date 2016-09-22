//
//  UIUtils.swift
//  Glup Business
//
//  Created by Cristian Palomino Rivera on 3/09/16.
//  Copyright © 2016 Glup. All rights reserved.
//

import Foundation
import UIKit

class UIUtil {
    
    class func transparentNavigationBar(_ viewController: UIViewController)
    {
        let navigationBar = viewController.navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        self.customizeNavigationBarTitle(viewController)
        self.customizeRightBarButtonItem(viewController)
        self.customizeLeftBarButtonItem(viewController)
    }
    
    // MARK: - Status Bar
    class func whiteStatusBar()
    {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    class func customizeRightBarButtonItem(_ viewController: UIViewController) {
        if let rightBarButtonItem = viewController.navigationItem.rightBarButtonItem {
            rightBarButtonItem.setTitleTextAttributes(
                [NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 14)!],
                for: UIControlState())
        }
    }
    
    class func customizeLeftBarButtonItem(_ viewController: UIViewController) {
        if let leftBarButtonItem = viewController.navigationItem.leftBarButtonItem {
            leftBarButtonItem.setTitleTextAttributes(
                [NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 14)!],
                for: UIControlState())
        }
    }
    
    class func customizeNavigationBarTitle(_ viewController: UIViewController) {
        if let navigationBar = viewController.navigationController?.navigationBar {
            navigationBar.titleTextAttributes =
                [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 16)!]
        }
    }
}
