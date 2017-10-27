//
//  ViewController.swift
//  Test App
//
//  Created by KELVIN LING SHENG SIANG on 27/10/2017.
//  Copyright © 2017 KELVIN LING SHENG SIANG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    struct CollectionViewCellIdentifiers {
        static let pageCell = "PageCell"
        static let noPageCell = "NoPageCell"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
//    var pages = [Page]()
    var pages = [Page(), Page(), Page()]
    var currentPageIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - collectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if pages.count == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.noPageCell, for: indexPath)
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellIdentifiers.pageCell, for: indexPath) as! PageCell
            let page = pages[indexPath.row]
            cell.label.text = page.letter
            cell.label.textColor = page.labelColor
            cell.webView.backgroundColor = page.webViewColor
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func addPage(_ sender: UIBarButtonItem) {
        let indexPath = collectionView.indexPathsForVisibleItems
        currentPageIndex = indexPath[0].row
        let page = Page()
        pages.insert(page, at: currentPageIndex)
        collectionView.insertItems(at: indexPath)
    }
    
    @IBAction func deletePage(_ sender: UIBarButtonItem) {
        let indexPath = collectionView.indexPathsForVisibleItems
        currentPageIndex = indexPath[0].row
        pages.remove(at: currentPageIndex)
        collectionView.deleteItems(at: indexPath)
    }
    
    
    
}

