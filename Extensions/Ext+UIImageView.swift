//
//  Ext+UIImageView.swift
//  TestMovie
//
//  Created by Pungki Busneri on 28/10/23.
//

import UIKit.UIImageView
import Kingfisher

public extension UIImageView {
    func setImage(with urlString: String, success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        let imgUrl = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: imgUrl, placeholder: nil, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage], completionHandler: {result in
            switch result {
            case .success:
                success?()
            case .failure:
                failure?()
            }
        })
    }
}
