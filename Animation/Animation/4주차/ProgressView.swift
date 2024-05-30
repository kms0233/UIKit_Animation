//
//  ProgressView.swift
//  Animation
//
//  Created by 김민서 on 5/24/24.
//

import UIKit

class ProgressView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(3 * Double.pi / 4)
    private var endPoint = CGFloat(Double.pi / 4)
    var animationCompletion: (() -> Void)? // 애니메이션 완료 클로저
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
    
    override func draw(_ rect: CGRect) {
        createCircularPath()
    }
    
    private func createCircularPath() {
        self.backgroundColor = .clear
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0),
                                        radius: (frame.size.height - 10) / 2.0,
                                        startAngle: startPoint,
                                        endAngle: endPoint,
                                        clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 10
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.addSublayer(circleLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.systemPink.cgColor
        layer.addSublayer(progressLayer)
    }
    
    func progressAnimation(duration: TimeInterval, value: Double) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = value
        circularProgressAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        circularProgressAnimation.delegate = self // 애니메이션 델리게이트 설정
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}

extension ProgressView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animationCompletion?() // 애니메이션 완료
        }
    }
}
