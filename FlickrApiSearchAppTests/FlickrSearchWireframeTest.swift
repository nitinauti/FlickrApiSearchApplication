//
//  FlickrSearchWireframeTest.swift
//  FlickrApiSearchAppTests
//
//  Created by Nitin Auti on 19/12/21.
//

import XCTest
import UIKit
@testable import FlickrApiSearchApp

final class FlickrSearchWireframeTest: XCTestCase {

    var wireFrameMock: FlickrSearchWireFrameMock!
 
    override func setUp() {
        super.setUp()
        wireFrameMock = FlickrSearchWireFrameMock()
    }

    override func tearDown() {
       wireFrameMock = nil
    }

    func testPresentFlickrSearchModule(){
        wireFrameMock.presentFlickrSearchModule()
        XCTAssertTrue(wireFrameMock.showFlickrPhotoDetailsCalled)
    }
   
}

final class FlickrSearchWireFrameMock: FlickrSearchWireFrameProtocol {
   
    
    var wireFrame: FlickrSearchWireFrameProtocol?
    var showFlickrPhotoDetailsCalled = false
    
    func presentFlickrSearchModule() {
         showFlickrPhotoDetailsCalled = true
        wireFrame?.presentFlickrSearchModule()
      }
    
}
