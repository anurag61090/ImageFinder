//
//  ImageDetailController.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/13/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import UIKit

class ImageDetailController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var imageArray: [SearchResult] = []
    var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        let indexPath = IndexPath(item: index, section: 0)
        self.imageCollectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
    
    func getImageArray(imageArray: [SearchResult], index: Int) {
        self.imageArray = imageArray
        self.index = index
    }
    
    // MARK: UICOLLECTIONVIEW DELEGATES & PROTOCOL
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCell
        cell?.setImageForDetail(searchData: self.imageArray[indexPath.row])
        return cell!
    }
    
    @IBAction func dismissController(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


