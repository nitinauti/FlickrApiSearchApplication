//
//  FlickrSearchInteractorTest.swift
//  FlickrApiSearchAppTests
//
//  Created by Nitin Auti on 19/12/21.
//

import XCTest
@testable import FlickrApiSearchApp

final class FlickrSearchInteractorTest: XCTestCase {
    
    var interactorMock: FlickrSearchInteractorMock!
    var presenter: FlickrSearchPresenterMock!
    var APIManager: APIManagerMock!

    
    override func setUp() {
        presenter = FlickrSearchPresenterMock()
        APIManager = APIManagerMock()
        interactorMock = FlickrSearchInteractorMock(presenter: presenter, APIManager: APIManager)
    }
    
    override func tearDown() {
        interactorMock = nil
        presenter = nil
    }
    
    func testLoadFlickrPhotos() {
        interactorMock?.loadFlickrPhotos(imageName: "nature", pageNum: 1)
        XCTAssertTrue(interactorMock.loadPhotosCalled)
    }
    
    
    func testLoadFlickrPhotosErrorResponse() {
        interactorMock.loadFlickrPhotos(imageName: "nature", pageNum: -1)
        XCTAssertTrue(interactorMock.loadPhotosCalled)
    }

}


final class FlickrSearchInteractorMock: FlickrSearchInteractorProtocol {
    var APIManager: FlickrSearchAPIManagerProtocol?
    weak var presenter: FlickrSearchPresenterProtocol?
    var loadPhotosCalled: Bool = false

    init(presenter: FlickrSearchPresenterProtocol,APIManager: FlickrSearchAPIManagerProtocol) {
        self.presenter = presenter
        self.APIManager = APIManager
        
    }
    
    func loadFlickrPhotos(imageName: String, pageNum: Int) {
        self.APIManager?.getFlickrSearch(imageName: imageName, pageNum: pageNum, completionHandler: { result  in
            self.loadPhotosCalled = true

            switch result {
            case .success(let FlickrSearch):
                self.presenter?.flickrSearchSuccess(flickrPhotos: FlickrSearch.photos)
            case .failure(let error):
                self.presenter?.flickrSearchError(error)
            }
        }
    )}
}
