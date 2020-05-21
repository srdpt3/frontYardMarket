//
//  ImageViewCollectionViewCell.swift
//  FrontYardMarket
//
//  Created by Dustin yang on 5/20/20.
//  Copyright © 2020 Dustin yang. All rights reserved.
//

import UIKit

class ImageViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupImageWith(itemImage: UIImage) {
           
           imageView.image = itemImage
       }

}
