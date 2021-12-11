//
//  ImageDownloader.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import Foundation
import UIKit

typealias ImageDownloadCompletionHander = ((UIImage?, Bool?, URL, Error?) -> Void)


protocol ImageDownloaderProtocol {
    func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat, completion: @escaping ImageDownloadCompletionHander)
}


class ImageDownloader: ImageDownloaderProtocol {

       let APIManager: FlickrSearchAPIManagerProtocol = FlickrSearchApiManager()

        private let imageCache = NSCache<NSString, UIImage>()
        
        static let shared = ImageDownloader()

        private init() {}
            
        func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat = UIScreen.main.scale, completion: @escaping ImageDownloadCompletionHander) {
          
            if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
                completion(cachedImage, true, imageURL, nil)
            } else {
                
                APIManager.downloadRequest(imageURL, size: size, scale: UIScreen.main.scale, completion: { [weak self] (result: Result<UIImage, NetworkError>) in
 
                    switch result {
                    case let .success(image):
                        print("downloadRequest",self?.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString))
                        self?.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                        completion(image, false, imageURL, nil)
                    case let .failure(error):
                        completion(nil, false, imageURL, error)
                    }
                }
                
              )}

        }
    
}

