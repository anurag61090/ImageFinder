//
//  ViewController.swift
//  ImageFinder
//
//  Created by Anurag Singh on 6/12/20.
//  Copyright © 2020 Anurag Singh. All rights reserved.
//

import UIKit
import SDWebImage
import ProgressHUD
import DropDown

class SearchResultController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var dropdown = DropDown()
    
    var searchModel: SearchResultModel?
    var searchResultArray: [SearchResult] = []
    var presentPage: Int = 1
    var PAGE_SIZE = 15
    var suggestionsArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        if let suggestions = userDefaults.value(forKey: "suggestions") as? Array<String> {
            suggestionsArray = suggestions
        }
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    // MARK: UISEARCHBAR DELEGATES
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        let userDefaults = UserDefaults.standard
        if let suggestions = userDefaults.value(forKey: "suggestions") as? Array<String> {
            suggestionsArray = suggestions
        }
        if self.suggestionsArray.count > 0 {
            self.initialiseDropdown()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.loadMoreData(initialLoad: true)
        searchBar.endEditing(true)
        self.searchModel = nil
        self.searchResultArray = []
        dropdown.hide()
    }
    
    private func initialiseDropdown() {
        
        dropdown.anchorView = searchBar
        dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
        dropdown.backgroundColor = .white
        dropdown.direction = .bottom
        dropdown.dataSource = suggestionsArray
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.searchBar.searchTextField.text = item
            self.loadMoreData(initialLoad: true)
            self.searchBar.endEditing(true)
            self.searchModel = nil
            self.searchResultArray = []
            self.dropdown.hide()
            print("Selected item: \(item) at index: \(index)") //Selected item: code at index: 0
        }
        dropdown.show()
    }
    
    // MARK: UICOLLECTIONVIEW DELEGATES
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.searchResultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCell
        cell?.setImage(searchData: self.searchResultArray[indexPath.row])
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell{
            let imagesize = cell.imageHolder.image?.size
            return imagesize!
        }
       return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailController") as? ImageDetailController {
            controller.getImageArray(imageArray: self.searchResultArray, index: indexPath.item)
            self.presentingViewController?.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    // MARK: API CALL TO FETCH IMAGES
    private func getImageData(queryParameter: String, page: Int, pageSize: Int) {
        
        APIManager.getImagesList(page: page, pageDataCount: pageSize, queryParameter: queryParameter) { (netObject) in
            ProgressHUD.dismiss()
            if let isSuccess = netObject.isSuccess {
                if isSuccess {
                    if let responseDict = netObject.responseObject as? Dictionary<String, AnyObject> {
                        self.searchModel = SearchResultModel(responseDict: responseDict)
                        if self.searchModel?.totaHits == 0 {
                            showAlertAppDelegate("Nothing Found!!!", message: "No data found for your search. Try different search", buttonTitle: "OK", window: self)
                        } else {
                            self.saveSuggestions(queryParameter: queryParameter)
                        }
                        self.searchResultArray.append(contentsOf: self.searchModel!.resultsArray)
                        self.imageCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // Save Suggestions
    private func saveSuggestions(queryParameter: String) {
        if self.suggestionsArray.contains(queryParameter) {
             self.suggestionsArray.removeAll { (item) -> Bool in
                 if item == queryParameter {
                     return true
                 }
                 return false
             }
         }
         if self.suggestionsArray.count == 10 {
            self.suggestionsArray.removeLast()
        }
        self.suggestionsArray.insert(queryParameter, at: 0)
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.suggestionsArray, forKey: "suggestions")
    }
    
    // MARK: UISCROLLVIEW DELEGATE
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        if self.searchResultArray.count < self.searchModel!.totaHits {
            let offsetY = scrollView.contentOffset.y;
            let contentHeight = scrollView.contentSize.height;

            if (offsetY > (contentHeight - 2*scrollView.frame.size.height + 500)) {
                self.loadMoreData()
            }
        }
    }
    
    // Method to handle pagination
    private func loadMoreData(initialLoad : Bool = false){
        let page = (initialLoad) ? presentPage : presentPage + 1
        if !initialLoad {
            self.presentPage += 1
        } else {
            self.initialiseProgressLoader()
        }
        let pageSize = PAGE_SIZE
        self.getImageData(queryParameter: self.searchBar.searchTextField.text!, page: page, pageSize: pageSize)
    }
    
    // Initialising Progress Loader
    private func initialiseProgressLoader() {
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.colorBackground = .clear
        ProgressHUD.colorAnimation = .systemRed
        ProgressHUD.show(icon: AlertIcon.search)
        ProgressHUD.show()
    }
}


