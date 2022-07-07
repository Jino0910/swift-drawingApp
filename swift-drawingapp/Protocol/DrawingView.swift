//
//  DrawingView.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/07.
//

import UIKit

enum DrawingViewType {
    case square
    case handDraw
}

class DrawingView: Drawable {
    var id: String = UUID().uuidString
    var type: DrawingViewType
    var color: UIColor
    var paths: [CGPoint]
    
    init(type: DrawingViewType,
         color: UIColor,
         paths: [CGPoint]) {
        self.type = type
        self.color = color
        self.paths = paths
    }
}

extension DrawingView: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: DrawingView, rhs: DrawingView) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
