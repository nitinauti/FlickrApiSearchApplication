//
//  FlickrSearchPhoto.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import Foundation

struct FlickrSearchPhoto: Codable {
    let photos : FlickrPhotos
    let stat : String
}

struct FlickrPhotos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [FlickrPhoto]
}

struct FlickrPhoto: Codable {
    let farm: Int
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
}
