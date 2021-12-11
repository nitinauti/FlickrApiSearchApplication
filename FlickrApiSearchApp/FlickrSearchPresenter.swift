//
//  FlickrSearchPresenter.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 10/12/21.
//

import Foundation
import UIKit

class FlickrSearchPresenter: FlickrSearchPresenterProtocol {
    
    var view: FlickrSearchViewProtocol?
    var interactor: FlickrSearchInteractorProtocol?
    var wireFrame: FlickrSearchWireFrameProtocol?
    
    var pageNum = Constants.defaultPageNum
    var totalCount = Constants.defaultTotalCount
    var totalPages = Constants.defaultPageNum
    var photoUrlList: [URL] = []

   
    /// append list of url to existing url array
    func addMorePhotoUrls(_ photoUrls: [URL]) {
        self.photoUrlList += photoUrls
    }
    
    func getSearchedFlickrPhotos(SearchImageName: String) {
        pageNum += 1
        interactor?.loadFlickrPhotos(imageName: SearchImageName, pageNum: pageNum)
    }
    
    func flickrSearchSuccess(flickrPhotos: FlickrPhotos) {
        let flickrPhotoUrlList = crateFlickrPhotoUrlList(from: flickrPhotos.photo)
        guard !flickrPhotoUrlList.isEmpty else {
            return
        }
        if totalCount == Constants.defaultTotalCount {
            self.photoUrlList = flickrPhotoUrlList
            totalCount = flickrPhotos.photo.count
            totalPages = flickrPhotos.pages
            DispatchQueue.main.async { [weak self] in
                self?.view?.displayFlickrSearchImages(with: self?.photoUrlList ?? [])
            }
        }else {
            self.addMorePhotoUrls(flickrPhotoUrlList)
            DispatchQueue.main.async { [weak self] in
                self?.view?.displayFlickrSearchImages(with: self?.photoUrlList ?? [])
            }
        }
    }
       
    func crateFlickrPhotoUrlList(from photos: [FlickrPhoto]) -> [URL] {
        let flickrPhotoUrlList = photos.compactMap { (photo) -> URL? in
            let url = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_z.jpg"
            guard let imageUrl = URL(string: url) else {
                return nil
            }
            return imageUrl
        }
        return flickrPhotoUrlList
    }
    
    
    func flickrSearchError(_ error: NetworkError) {
        
    }
    
    
}
