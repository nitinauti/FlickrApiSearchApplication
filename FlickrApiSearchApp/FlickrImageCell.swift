//
//  FlickrImageCell.swift
//  FlickrApiSearchApp
//
//  Created by Nitin Auti on 11/12/21.
//

import UIKit

class FlickrImageCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(imageURL: URL,size: CGSize,indexPath: IndexPath) {
        photoImage.loadImage(with: imageURL, size: size)
      }
    
}

