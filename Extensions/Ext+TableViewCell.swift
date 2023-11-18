//
//  Ext+TableViewCell.swift
//  TestMovie
//
//  Created by Pungki Busneri on 28/10/23.
//

import UIKit.UITableViewCell

public extension UITableViewCell {
    func dateFormat(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        let resultString = dateFormatter.string(from: date!)
        return resultString
    }
}



