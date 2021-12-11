//
//  FlickrSearchProtocols.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import Foundation
import UIKit

protocol FlickrSearchViewProtocol: class {
    var presenter: FlickrSearchPresenterProtocol? { get set }
    func displayFlickrSearchImages(with urlList: [URL])

}

protocol FlickrSearchWireFrameProtocol: class {
    static func presentFlickrSearchModule(fromView:AnyObject)
    
}

protocol FlickrSearchPresenterProtocol: class {
    var view: FlickrSearchViewProtocol? { get set }
    var interactor: FlickrSearchInteractorProtocol? { get set }
    var wireFrame: FlickrSearchWireFrameProtocol? { get set }
    
    func getSearchedFlickrPhotos(SearchImageName: String)
    func flickrSearchSuccess(flickrPhotos: FlickrPhotos)
    func flickrSearchError(_ error: NetworkError)

}

protocol FlickrSearchInteractorProtocol: class {
    var presenter: FlickrSearchPresenterProtocol? { get set }
    var APIManager: FlickrSearchAPIManagerProtocol? { get set }
    
    func loadFlickrPhotos(imageName: String, pageNum: Int)
    
}

protocol FlickrSearchAPIManagerProtocol: class {

    func getFlickrSearch(imageName: String, pageNum: Int,
                    completionHandler: @escaping (Result<FlickrSearchPhoto, NetworkError>) -> ())
    
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat,
                   completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}
