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
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var noPageLbl: UILabel!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
//    var pages = [Page]()
    var pages = [Page(), Page(), Page()]
    var currentPageIndex: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(nibName: CollectionViewCellIdentifiers.noPageCell, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: CollectionViewCellIdentifiers.noPageCell)
        noPageLbl.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - collectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pages.count == 0 {
            return 0
        } else {
            return pages.count
        }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pages.count == 0 {
            currentPageIndex = nil
            configureButton()
        } else {
            currentPageIndex = indexPath.row
            configureButton()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func addPage(_ sender: UIBarButtonItem) {
        if currentPageIndex == nil && pages.count == 0 {
            currentPageIndex = 0
        }
        let pageIndex = currentPageIndex!
        let indexPath = IndexPath(row: pageIndex, section: 0)
        let page = Page()
        pages.insert(page, at: pageIndex)
        collectionView.insertItems(at: [indexPath])
        noPageLbl.isHidden = true
    }
    
    @IBAction func deletePage(_ sender: UIBarButtonItem) {
        if pages.count > 0 && currentPageIndex != nil {
            if let pageIndex = currentPageIndex {
                let indexPath = IndexPath(row: pageIndex, section: 0)
                let previousIndexPath = IndexPath(row: pageIndex - 1, section: 0)
                pages.remove(at: pageIndex)
                collectionView.deleteItems(at: [indexPath])
                if pages.count == 0 {
                    noPageLbl.isHidden = false
                    currentPageIndex = nil
                }
                if currentPageIndex == 0 || currentPageIndex == nil {
                    return
                } else {
                    collectionView.scrollToItem(at: previousIndexPath, at: .left, animated: true)
                }
            }
        } else {
            noPageLbl.isHidden = false
            return
        }
    }
    
    @IBAction func previousBtnTapped(_ sender: UIBarButtonItem) {
        if currentPageIndex == 0 || currentPageIndex == nil {
            return
        }
        let indexPath = IndexPath(row: currentPageIndex! - 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    @IBAction func nextBtnTapped(_ sender: UIBarButtonItem) {
        if currentPageIndex == (pages.count - 1) || currentPageIndex == nil {
            return
        }
        let indexPath = IndexPath(row: currentPageIndex! + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    func configureButton() {
        let enabledColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 1)
        let disabledColor = UIColor(red: 255/255, green: 38/255, blue: 0/255, alpha: 0.5)
        if pages.count < 2 {
            previousButton.tintColor = disabledColor
            nextButton.tintColor = disabledColor
        } else {
            if currentPageIndex == 0 {
                previousButton.tintColor = disabledColor
                nextButton.tintColor = enabledColor
            } else if currentPageIndex == (pages.count - 1) {
                previousButton.tintColor = enabledColor
                nextButton.tintColor = disabledColor
            } else {
                previousButton.tintColor = enabledColor
                nextButton.tintColor = enabledColor
            }
        }
    }
    
}

