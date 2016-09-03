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
    
    class func transparentNavigationBar(viewController: UIViewController)
    {
        let navigationBar = viewController.navigationController!.navigationBar
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = false
        
        self.customizeNavigationBarTitle(viewController)
        self.customizeRightBarButtonItem(viewController)
        self.customizeLeftBarButtonItem(viewController)
    }
    
    // MARK: - Status Bar
    class func whiteStatusBar()
    {
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    class func customizeRightBarButtonItem(viewController: UIViewController) {
        if let rightBarButtonItem = viewController.navigationItem.rightBarButtonItem {
            rightBarButtonItem.setTitleTextAttributes(
                [NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 14)!],
                forState: UIControlState.Normal)
        }
    }
    
    class func customizeLeftBarButtonItem(viewController: UIViewController) {
        if let leftBarButtonItem = viewController.navigationItem.leftBarButtonItem {
            leftBarButtonItem.setTitleTextAttributes(
                [NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 14)!],
                forState: UIControlState.Normal)
        }
    }
    
    class func customizeNavigationBarTitle(viewController: UIViewController) {
        if let navigationBar = viewController.navigationController?.navigationBar {
            navigationBar.titleTextAttributes =
                [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Montserrat-Light", size: 16)!]
        }
    }
}