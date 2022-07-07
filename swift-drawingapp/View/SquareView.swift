//
//  SquareView.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/06.
//

import Foundation
import UIKit

class SquareView: UIView {
    var drawable: Drawable
    
    init(drawable: Drawable) {
        self.drawable = drawable
        super.init(frame: .zero)
        
        draw()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func draw() {
        self.clipsToBounds = true
        
        self.backgroundColor = drawable.color
        self.frame = self.frameFromSquare(paths: drawable.paths)
    }
    
    private func frameFromSquare(paths: [CGPoint]) -> CGRect {
        let xArray = paths.map{ $0.x }
        let yArray = paths.map{ $0.y }
        if let minX = xArray.min(),
           let maxX = xArray.max(),
           let minY = yArray.min(),
           let maxY = yArray.max() {
            return CGRect(x: minX,
                          y: minY,
                          width: maxX-minX,
                          height: maxY-minY)
        } else {
            return .zero
        }
    }
    
    
}

