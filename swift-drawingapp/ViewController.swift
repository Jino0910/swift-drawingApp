//
//  ViewController.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    @IBOutlet weak var addSquareButton: UIButton!
    @IBOutlet weak var drawingButton: UIButton!
    @IBOutlet weak var drawLineView: DrawLineView!
    
    var lastPoint = CGPoint.zero
    var movePoints: [CGPoint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRx()
    }
}

extension ViewController {
    
    private func setupUI() {
        drawLineView.delegate = self
    }
    
    private func setupRx() {
        setupAction()
        setupBinding()
    }
    
    private func setupAction() {
        
        addSquareButton.rx.tap
            .bind(to: viewModel.action.addSquare)
            .disposed(by: disposeBag)
        
        let drawingButtonShare = drawingButton.rx.tap.share()
        
        drawingButtonShare
            .bind(to: drawingButton.rx.toggle)
            .disposed(by: disposeBag)
        
        drawingButtonShare
            .map{ !self.drawingButton.isSelected }
            .bind(to: drawLineView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func setupBinding() {
        viewModel.state.drawables
            .bind(to: view.rx.drawableAddSubviews)
            .disposed(by: disposeBag)
    }
}

extension ViewController: DrawLineViewDelegate {
    func completeDrawing(color: UIColor,
                         paths: [CGPoint]) {
        viewModel.action.addLine.accept((color, paths))
    }
}

extension Reactive where Base: UIView {
    var drawableAddSubviews: Binder<[Drawable]> {
        return Binder(base) { parentsView, drawables in
            parentsView.subviews.forEach{
                if !($0 is UIButton) && !($0 is DrawLineView){
                    $0.removeFromSuperview()
                }
            }
            drawables.forEach { drawable in
                switch drawable.type {
                case .square:
                    let view = SquareView(drawable: drawable)
                    parentsView.addSubview(view)
                case .handDraw:
                    let view = LineView(drawable: drawable)
                    parentsView.addSubview(view)
                }
            }
        }
    }
}

extension Reactive where Base: UIButton {
    var toggle: Binder<Void> {
        return Binder(base) { button, _ in
            button.isSelected = !button.isSelected
        }
    }
}
