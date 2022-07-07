//
//  LineView.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/07.
//

import Foundation
import UIKit

class LineView: UIView {
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
        
        for index in 0..<self.drawable.paths.count-1 {
            self.draw(from: self.drawable.paths[index],
                      to: self.drawable.paths[index+1])
        }
    }
    
    private func draw(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        let path = UIBezierPath()
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = drawable.color.cgColor
        shapeLayer.lineWidth = 2
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
}

