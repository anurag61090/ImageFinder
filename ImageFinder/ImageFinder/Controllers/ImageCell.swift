//
//  ImageCell.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/13/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    // Set Image from model
    func setImage(searchData: SearchResult) {
        imageHolder.sd_setImage(with: URL(string: searchData.previewURL), completed: nil)
    }
    
    func setImageForDetail(searchData: SearchResult)  {
        imageHolder.sd_setImage(with: URL(string: searchData.largeImageURL), completed: nil)
    }
}
