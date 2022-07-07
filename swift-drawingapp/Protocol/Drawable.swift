//
//  Drawable.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/07.
//

import UIKit

protocol Drawable {
    var id: String { get }
    var type: DrawingViewType { get }
    var color: UIColor { get }
    var paths: [CGPoint] { get }
}
