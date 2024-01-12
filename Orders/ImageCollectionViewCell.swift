//
//  ImageCollectionViewCell.swift
//  Orders
//
//  Created by Azhad Khan on 09/01/24.
//

import UIKit



class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewBackground: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
       // collectionView.layer.cornerRadius = 10
    }
}
