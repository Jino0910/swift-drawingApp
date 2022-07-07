//
//  ViewModel.swift
//  swift-drawingapp
//
//  Created by jinho on 2022/07/04.
//

import RxSwift
import RxCocoa

typealias DrawValues = (UIColor, [CGPoint])

class ViewModel {
    
    let disposeBag = DisposeBag()
    
    var action = Action()
    var state = State()
    
    struct Action {
        var addSquare = PublishRelay<Void>()
        var addLine = PublishRelay<DrawValues>()
    }
    
    struct State {
        var drawables = BehaviorRelay<[Drawable]>(value: [])
    }
    
    init() {
        binding()
    }
    
    func binding() {
        
        action.addSquare
            .flatMap{ [weak self]_ -> Observable<[Drawable]> in
                guard let self = self else { return .empty() }
                return Observable.just(self.state.drawables.value + [self.randomSquareView()])
            }
            .bind(to: state.drawables)
            .disposed(by: disposeBag)
        
        action.addLine
            .flatMap{ [weak self]drawValues -> Observable<[Drawable]> in
                guard let self = self else { return .empty() }
                return Observable.just(self.state.drawables.value +
                                       [self.randomDrawLineView(color: drawValues.0,
                                                                paths: drawValues.1)])
            }
            .bind(to: state.drawables)
            .disposed(by: disposeBag)
    }
}

extension ViewModel {
    
    private func randomSquareView() -> DrawingView {
        DrawingView(type: .square,
                    color: UIColor.randomColor(),
                                         paths: randomPaths())
    }
    
    private func randomDrawLineView(color: UIColor,
                                    paths: [CGPoint]) -> DrawingView {
        DrawingView(type: .handDraw,
                    color: color,
                    paths: paths)
    }
}

extension ViewModel {
    
    private func randomPaths() -> [CGPoint] {
        let distance = 100
        let minX = (0...Int(UIScreen.main.bounds.width)-distance).randomElement() ?? 0
        let minY = (100...Int(UIScreen.main.bounds.height)-distance).randomElement() ?? 100
        return [CGPoint(x: minX, y: minY),
                CGPoint(x: minX + distance, y: minY),
                CGPoint(x: minX, y: minY + distance),
                CGPoint(x: minX + distance, y: minY + distance)]
    }
}
