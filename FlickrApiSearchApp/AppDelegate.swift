//
//  AppDelegate.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FlickrSearchWireframe().presentFlickrSearchModule()
        
        return true
    }

}

