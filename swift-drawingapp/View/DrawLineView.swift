//
//  DrawLineView.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/07.
//

import UIKit

protocol DrawLineViewDelegate: AnyObject {
    func completeDrawing(color: UIColor,
                         paths: [CGPoint])
}

class DrawLineView: UIView {
    
    private var isMoved: Bool = false
    private var lastPoint = CGPoint.zero
    private var movePoints: [CGPoint] = []
    private var color: UIColor = UIColor.randomColor()
    var delegate: DrawLineViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reset() {
        self.isMoved = false
        self.lastPoint = .zero
        self.movePoints = []
        self.color = UIColor.randomColor()
        self.layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        self.lastPoint = touch.location(in: self)
        self.movePoints.append(self.lastPoint)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        self.isMoved = true
        let currentPoint = touch.location(in: self)
        self.draw(from: self.lastPoint,
                  to: currentPoint)
        self.lastPoint = currentPoint
        self.movePoints.append(self.lastPoint)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.delegate?.completeDrawing(color: self.color,
                                  paths: self.movePoints)
        self.reset()
    }
    
    private func draw(from fromPoint: CGPoint, to toPoint: CGPoint) {

        let path = UIBezierPath()
        path.move(to: fromPoint)
        path.addLine(to: toPoint)
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        
        self.layer.addSublayer(shapeLayer)
    }
}
