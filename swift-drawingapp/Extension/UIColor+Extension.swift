//
//  UIColor+Extension.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/07.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        [UIColor.blue,
         // .systemCyan,
         .systemGray,
         // .systemMint,
         .systemPink,
         .systemBrown,
         .systemIndigo,
         .systemOrange,
         .systemPurple,
         .systemYellow,
         .systemTeal].randomElement()!
    }
}
