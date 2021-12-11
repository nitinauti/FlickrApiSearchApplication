//
//  NavaigationHelper.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import Foundation
import UIKit

public class NavaigationHelper: UINavigationController {
    
    static var window: UIWindow?
    static var RootViewController = UINavigationController()
    
    static func setRootViewController(ViewController: UIViewController){
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: ViewController)
        window?.makeKeyAndVisible()
    }
    
    static func PushViewController(ViewController: UIViewController){
        RootViewController.pushViewController(ViewController, animated: true)
    }
    
    
}
