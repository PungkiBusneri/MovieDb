//
//  Ext+UIViewController.swift
//  TestMovie
//
//  Created by Pungki Busneri on 28/10/23.
//

import UIKit.UIViewController

public extension UIViewController {
    func calculateTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 60 % 60
        let minutes = Int(time) % 60
        return String(format: "%2i h %2i m", hours, minutes)
    }
    func resizeRefreshControl(from refresh: UIRefreshControl) {
        refresh.tintColor = .gray
        refresh.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
    }
}
