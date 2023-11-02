//
//  Ext+UIImage.swift
//  TestMovie
//
//  Created by Pungki Busneri on 28/10/23.
//

import UIKit.UIImage

public extension UIImage {
    @objc class var icSearch: UIImage {
        return UIImage.init(named: "ic_Search") ?? UIImage()
    }
    @objc class var icDefaultProfile: UIImage {
        return UIImage.init(named: "ic_default_profile") ?? UIImage()
    }
}
