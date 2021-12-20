//
//  FlickrSearchViewControllerTest.swift
//  FlickrApiSearchAppTests
//
//  Created by Nitin Auti on 13/12/21.
//

import XCTest
@testable import FlickrApiSearchApp

class FlickrSearchViewControllerTest: XCTestCase {
    
    var viewMock: FlickrSearchViewControllerMock!
    var flickrPhoto: FlickrPhoto?
    var presenterMock: FlickrSearchPresenterMock!

    override func setUp() {
        presenterMock = FlickrSearchPresenterMock()
        viewMock = FlickrSearchViewControllerMock(presenter: presenterMock)
    }
    
    override func tearDown() {
        viewMock = nil
        presenterMock = nil
    }
    
    
}

class FlickrSearchViewControllerMock: FlickrSearchViewProtocol {
   
    var presenter: FlickrSearchPresenterProtocol?
    
    var showFlickrImages = false
    var flickrSearchErrorCalled = false


    init(presenter: FlickrSearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func displayFlickrSearchImages(with viewModel: FlickrSearchModel) {
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertTrue(viewModel.photoUrlList.count == 2)
        showFlickrImages = true
    }
    
    func flickrSearchError(_ error: NetworkError) {
        XCTAssertNotNil(presenter?.flickrSearchError(error))
        flickrSearchErrorCalled = true
    }
    
    func resetViews() {
        
    }
    
}
