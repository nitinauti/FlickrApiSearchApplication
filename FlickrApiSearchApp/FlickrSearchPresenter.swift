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
    var flickrSearchModel: FlickrSearchModel!

    
    var pageNum = Constants.defaultPageNum
    var totalCount = Constants.defaultTotalCount
    var totalPages = Constants.defaultPageNum
    
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
            flickrSearchModel = FlickrSearchModel(photoUrlList: flickrPhotoUrlList)
            totalCount = flickrPhotos.photo.count
            totalPages = flickrPhotos.pages
            DispatchQueue.main.async { [unowned self] in
                self.view?.displayFlickrSearchImages(with: self.flickrSearchModel)
            }
        }else {
            appendMoreFlickrPhotos(flickrPhotoUrlList: flickrPhotoUrlList)
        }
    }
    
    /// method called after suseesfully load first page .
    fileprivate func appendMoreFlickrPhotos(flickrPhotoUrlList: [URL]) {
        totalCount += flickrPhotoUrlList.count
        flickrSearchModel.addMorePhotoUrls(flickrPhotoUrlList)
      
        DispatchQueue.main.async { [unowned self] in
            self.view?.displayFlickrSearchImages(with: self.flickrSearchModel)
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
        view?.flickrSearchError(error)
    }
    
    func clearData() {
        pageNum = Constants.defaultPageNum
        totalCount = Constants.defaultTotalCount
        totalPages = Constants.defaultTotalCount
        view?.resetViews()
        flickrSearchModel = nil
    }
    
}
