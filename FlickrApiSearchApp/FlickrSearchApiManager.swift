//
//  FlickrSearchApiManager.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import Foundation
import UIKit

class FlickrSearchApiManager : FlickrSearchAPIManagerProtocol {
    
    //MARK: Download FlickrData form dataTask
    func getFlickrSearch(imageName: String, pageNum: Int, completionHandler: @escaping (Result<FlickrSearchPhoto, NetworkError>) -> ()) {
        
       let url = Constants.baseUrl + "text=\(imageName)&page=\(pageNum)&per_page=\(Constants.defaultPageSize)"
        
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { Data, response, error -> Void in
            
            guard let data = Data else {
                completionHandler(.failure(NetworkError.emptyData))
                return
            }
            
            do {
                let decodedResult = try JSONDecoder().decode(FlickrSearchPhoto.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(.success(decodedResult))
                }
                    return
            } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(NetworkError.decodingError))
                    }
                    return
                }
           })
        
            task.resume()
    }
    
    //MARK: Download image form downloadRequest
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        let Task = URLSession.shared.downloadTask(with: url) { (Url: URL?, response: URLResponse?, error: Error?) in
            
            guard let url = Url else {
                completion(.failure(.emptyData))
                return
            }
            
            guard let downloadedImage = self.downsampleImage(url: url, pointSize: size, scale: scale) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(downloadedImage))
            
        }
        Task.resume()
        
    }
    
    //MARK: Resise Image to given Size
    func downsampleImage(url: URL, pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions) else {
            return nil
        }
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
        guard let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        return UIImage(cgImage: downSampledImage)
    }
    
    
}
