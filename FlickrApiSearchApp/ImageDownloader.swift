//
//  ImageDownloader.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import Foundation
import UIKit

typealias ImageDownloadCompletionHander = ((UIImage?, Bool?, URL, Error?) -> Void)

class ImageDownloader {
    
        private let imageCache = NSCache<NSString, UIImage>()
        
        /// created que for adding number of concurrent opration to be added
        lazy var downloadQueue: OperationQueue = {
            let queue = OperationQueue()
            queue.name = "com.async.image.downloadQueue"
            queue.maxConcurrentOperationCount = 5
            queue.qualityOfService = .userInitiated
            return queue
        }()
        
        static let shared = ImageDownloader()
       
        private init() {}
        
        /// Dwon load image from umage URL
        func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat = UIScreen.main.scale, completion: @escaping ImageDownloadCompletionHander) {
          
            if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
                completion(cachedImage, true, imageURL, nil)
                // if image is present it cache get it from herer
           
            } else if let existingImageOperations = downloadQueue.operations as? [ImageOperation],
               
                let imgOperation = existingImageOperations.first(where: {
                    return ($0.imageURL == imageURL) && $0.isExecuting && !$0.isFinished
                }){
                imgOperation.queuePriority = .high
           
            } else {
               
                let imageOperation = ImageOperation(imageURL: imageURL, size: size, scale: scale)
                imageOperation.queuePriority = .veryHigh
                imageOperation.imageDownloadCompletionHandler = { [unowned self] result in
                    switch result {
                    case let .success(image):
                        self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                        completion(image, false, imageURL, nil)
                    case let .failure(error):
                        completion(nil, false, imageURL, error)
                    }
                }
                downloadQueue.addOperation(imageOperation)
            }
        }
        
        /// for cancel all opration
        func cancelAll() {
            downloadQueue.cancelAllOperations()
        }
        
        /// for cancel single opration
        func cancelOperation(imageUrl: URL) {
            if let imageOperations = downloadQueue.operations as? [ImageOperation],
                let operation = imageOperations.first(where: { $0.imageURL == imageUrl }) {
                operation.cancel()
            }
        }
    }


