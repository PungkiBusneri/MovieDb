//
//  MyCollectionViewCell.swift
//  TestMovie
//
//  Created by Pungki Busneri on 13/10/23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myCastImage: UIImageView!
    
    @IBOutlet var myCastName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myCastName.lineBreakMode = .byWordWrapping
        myCastImage.layer.cornerRadius = myCastImage.frame.height / 2
        // Initialization code
    }
    func setupCell(data: Cast?) {
        if let cast = data {
            myCastName.text = cast.name
            myCastImage.setImage(with: ImageUrl.Poster + cast.profilePath, failure: {
                self.myCastImage.image = UIImage.icDefaultProfile
            })
        }
    }
}
