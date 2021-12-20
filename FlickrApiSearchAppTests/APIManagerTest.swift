//
//  APIManagerMockTest.swift
//  FlickrApiSearchAppTests
//
//  Created by Nitin Auti on 19/12/21.
//

import XCTest
@testable import FlickrApiSearchApp

final class APIManagerTest: XCTestCase {
    var apiManagerMock: APIManagerMock!
   
    override func setUp() {
        apiManagerMock = APIManagerMock()
    }
    
    override func tearDown() {
        apiManagerMock = nil
    }
}


class APIManagerMock: FlickrSearchAPIManagerProtocol {
       
    func getFlickrSearch(imageName: String, pageNum: Int, completionHandler: @escaping (Result<FlickrSearchPhoto, NetworkError>) -> ()) {
         
        if let fileUrl = Bundle.main.url(forResource: "FlickerAPISearchTestData", withExtension: "json"){

            let data = try! Data(contentsOf: fileUrl)
                
                do {
                    let decodedResult = try JSONDecoder().decode(FlickrSearchPhoto.self, from: data)
                     completionHandler(.success(decodedResult))
                        return
                } catch {
                        completionHandler(.failure(NetworkError.decodingError))
                        return
                    }
            }
        
            
    }
    
    
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
    }
        
}
