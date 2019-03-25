//
//  ViewController.swift
//  CollectionViews
//
//  Created by Rose Maina on 11/03/2019.
//  Copyright © 2019 Rose Maina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addItemBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var collectionData = ["1 🥀", "2 🎃", "3 🍑", "4 🐈", "5 🤡", "6 🎮",
                          "7 👻", "8 🥁", "9 🏰", "10 🏺", "11 📢", "12 ♛"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCellSize()
        setupRefreshControl()
    
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewSegue" {
            if let detailVc = segue.destination as? DetailViewController,
                let index = sender as? IndexPath {
                detailVc.selectedText = collectionData[index.row]
            }
        }
    }
    
    // Ensures any editing related stuff is handled properly
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addItemBarButton.isEnabled = !editing
        
        // allow multiple cell selection
        collectionView.allowsMultipleSelection = editing
        collectionView.indexPathsForSelectedItems?.forEach({ (indexPath) in
            collectionView.deselectItem(at: indexPath, animated: false)
        })
        
        //cells editing mode changes, when edit button is tapped
        let indexPaths = collectionView.indexPathsForVisibleItems
        
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            cell.isEditing = editing
        }

        if !editing {
            navigationController?.isToolbarHidden = true
        }
    }
}

extension ViewController {
    
    @objc func refresh() {
        addItems()
        collectionView.refreshControl?.endRefreshing()
    }
    
    func setupCellSize() {
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    func setupRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh) , for: .valueChanged)
    }
    
    @IBAction func addItems() {
        let text = "\(collectionData.count + 1) 😎"
        collectionData.append(text)
        let indexPath = IndexPath(row: collectionData.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
        
        //        collectionView.performBatchUpdates({
        //            for _ in 0 ..< 3 {
        //                let text = "\(collectionData.count + 1) 😎"
        //                collectionData.append(text)
        //                let indexPath = IndexPath(row: collectionData.count - 1, section: 0)
        //                collectionView.insertItems(at: [indexPath])
        //            }
        //        }, completion: nil)
    }
    
    @IBAction func deleteItems() {
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            let items = selectedItems.map { $0.item }.sorted().reversed()
            
            for item in items {
                collectionData.remove(at: item)
            }
            collectionView.deleteItems(at: selectedItems)
        }
        navigationController?.isToolbarHidden = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.titleLabel.text = collectionData[indexPath.row]
        cell.isEditing = isEditing
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems, selected.count == 0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            performSegue(withIdentifier: "detailViewSegue", sender: indexPath)
        } else {
            navigationController?.isToolbarHidden = false
        }
    }
}
