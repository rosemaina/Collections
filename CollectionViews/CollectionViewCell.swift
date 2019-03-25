//
//  CollectionViewCell.swift
//  CollectionViews
//
//  Created by Rose Maina on 12/03/2019.
//  Copyright © 2019 Rose Maina. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedImage: UIImageView!
    
    var isEditing: Bool = false {
        didSet {
            selectedImage.isHidden = !isEditing //Not editing
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                selectedImage.image = isSelected ? UIImage(named: "Checked") : UIImage(named: "Unchecked")
            }
        }
    }
}
