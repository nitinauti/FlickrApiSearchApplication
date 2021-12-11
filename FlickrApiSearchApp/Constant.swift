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
    static let defaultPageSize: Int = 30
    static var FlickrImageCellIdentifire = "FlickrImageCell"
    static var placeholder = "Search here"
    static var FlickrImageCell = "FlickrImageCell"
    static var FlickrSearchViewController = "FlickrSearchViewController"
    static var FlickrSearchViewIdentifire = "FlickrSearchViewController"
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
