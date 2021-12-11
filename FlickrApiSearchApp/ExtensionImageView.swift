//
//  ImageLoader.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import UIKit

extension UIImageView {

    func loadImage(with imageURL: URL, placeholder: UIImage? = UIColor.black.image(), size: CGSize) {

        image = placeholder

        ImageDownloader.shared.downloadImage(withURL: imageURL, size: size, completion: { [weak self] (image, isCached, url, error) in

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
}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
