//
//  UILabelExtension.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 21/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit

extension UILabel {
    func setGrayBorder(){
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4
    }
}
