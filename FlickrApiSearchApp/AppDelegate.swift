//
//  AppDelegate.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // configureURLCache()
        FlickrSearchWireframe.presentFlickrSearchModule(fromView: FlickrSearchViewController())
        return true
    }
    
    /// Configure URLCache for Image Caching
    fileprivate func configureURLCache() {
        let memoryCapacity = 500 * 1024 * 1024 // 500 MB Memory Cache
        let diskCapacity = 5000 * 1024 * 1024 // 500 MB Disk Cache
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "DataCachePath")
        URLCache.shared = cache
    }
    
}

