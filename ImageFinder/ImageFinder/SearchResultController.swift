//
//  ViewController.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import UIKit

class SearchResultController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getImageData()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCell
        cell?.setImage(imageName: "test\(indexPath.item)")
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell{
            let imagesize = cell.imageHolder.image?.size
            return imagesize!
        }
       return CGSize(width: 150, height: 150)
    }
    
    func getImageData() {
        APIManager.getImagesList(page: 1, pageDataCount: 20, queryParameter: "flower") { (netObject) in
            if let isSuccess = netObject.isSuccess {
                if isSuccess {
                    if let json = netObject.responseObject as? Dictionary<String, AnyObject> {
                        print(json)
                    }
                }
            }
        }
    }
}

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageHolder: UIImageView!
    
    func setImage(imageName: String) {
        imageHolder.image = UIImage(named: imageName)
    }
}

