//
//  Constant.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import Foundation
import UIKit

enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let numberOfColumns: CGFloat = 3
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 50
    static let FlickrImageCellIdentifire = "FlickrImageCell"
    static let placeholder = "Search here"
    static let FlickrImageCell = "FlickrImageCell"
    static let FlickrSearchViewController = "FlickrSearchViewController"
    static let FlickrSearchViewIdentifire = "FlickrSearchViewController"
    static let baseUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=2932ade8b209152a7cbb49b631c4f9b6&%20format=json&nojsoncallback=1&safe_search=1&"
}

enum NetworkError: Swift.Error, CustomStringConvertible {
    
    case apiError(Swift.Error)
    case noInternetError
    case emptyData
    case decodingError
    case somethingWentWrong
    
    public var description: String {
        switch self {
        case let .apiError(error):
            return "Network Error: \(error.localizedDescription)"
        case .decodingError:
            return "Json Decoding Error."
        case .emptyData:
            return "Empty response from the server"
        case .somethingWentWrong:
            return "Something went wrong."
        case .noInternetError:
             return "No internet connection. Please try again after some time"
        }
    }
}
