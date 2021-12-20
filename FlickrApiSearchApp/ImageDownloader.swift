//
//  ImageLoader.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()
typealias ImageDownloadCompletionHander = ((UIImage?, Bool?, URL, Error?) -> Void)

extension UIImageView: ImageDownloaderProtocol {
   
    var APIManager: FlickrSearchAPIManagerProtocol {
        return FlickrSearchApiManager()
    }
    
    func loadImage(with imageURL: URL, placeholder: UIImage? = UIColor.black.image(), size: CGSize) {

        image = placeholder

        self.downloadImage(withURL: imageURL, size: size, scale: UIScreen.main.scale, completion: { [weak self] (image, isCached, url, error) in

            guard let self = self else {
                    return
                }
            DispatchQueue.main.async {
                  if let downloadedImage = image, let isCached = isCached {
                          if isCached {
                            print("isCached",isCached)
                               self.image = downloadedImage
                          } else {
                                UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                                self.image = downloadedImage
                            }, completion: nil)
                          }
                    } else {
                        self.image = placeholder
                    }
                }
            }
        )
    }
    
    
    func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat, completion: @escaping ImageDownloadCompletionHander) {
        
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            completion(cachedImage, true, imageURL, nil)
        } else {
            
            APIManager.downloadRequest(imageURL, size: size, scale: UIScreen.main.scale, completion: { (result: Result<UIImage, NetworkError>) in
                
                switch result {
                case let .success(image):
                    print("downloadRequest", imageCache.setObject(image, forKey: imageURL.absoluteString as NSString))
                    imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                    completion(image, false, imageURL, nil)
                case let .failure(error):
                    completion(nil, false, imageURL, error)
                }
            }
        )}
        
     }
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
