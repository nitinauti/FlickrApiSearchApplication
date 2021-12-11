//
//  loadImage.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 12/12/21.
//

import Foundation
import UIKit

//class loadImageView: UIImageView {
//    
//    let imageDownloader: ImageDownloaderProtocol = ImageDownloader()
//
//    func loadImage(with imageURL: URL, placeholder: UIImage? = UIColor.black.image(), size: CGSize) {
//       
//        image = placeholder
//         
//        imageDownloader.downloadImage(withURL: imageURL, size: size, scale:  UIScreen.main.scale, completion: { [weak self] (image, isCached, url, error) in
//               
//            guard let self = self else {
//                    return
//                }
//               
//            DispatchQueue.main.async {
//
//                  if let downloadedImage = image, let isCached = isCached {
//                          if isCached {
//                            print("isCached", isCached)
//
//                            self.image = downloadedImage
//                          } else {
//                                UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
//                                self.image = downloadedImage
//                            }, completion: nil)
//                          }
//                    } else {
//                        self.image = placeholder
//                    }
//                }
//            }
//        )
//    }
//}
