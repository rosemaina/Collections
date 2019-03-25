//
//  DetailViewController.swift
//  CollectionViews
//
//  Created by Rose Maina on 11/03/2019.
//  Copyright © 2019 Rose Maina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!
    
    var selectedText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsLabel.text = selectedText
    }
}
