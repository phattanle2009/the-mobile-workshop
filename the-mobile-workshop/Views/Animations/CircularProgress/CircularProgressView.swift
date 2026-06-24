//
//  CircularProgressView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 28/1/26.
//

import UIKit

class CircularProgressView: UIView {

    private var startAngle: CGFloat = -.pi / 2 {
        didSet { updatePaths() }
    }

    private var endAngle: CGFloat = 3 * .pi / 2 {
        didSet { updatePaths() }
    }

    private var progress: CGFloat {
        get { _progress }
        set { setProgress(newValue, animated: false) }
    }

    private var _progress: CGFloat = 0
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private var circularBackgroundColor: UIColor = .clear
    private var gradientProgressColors: [UIColor] = []
    private var lineWidth: CGFloat = 6.0

    init(bgColor: UIColor, gradientColors: [UIColor]) {
        self.circularBackgroundColor = bgColor
        self.gradientProgressColors = gradientColors
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)

        // gradient
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = gradientProgressColors.map { $0.cgColor }
        layer.addSublayer(gradientLayer)

        // mask
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        gradientLayer.mask = progressLayer

        // update path
        updatePaths()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updatePaths()
    }

    private func updatePaths() {
        let centerPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2

        let path = UIBezierPath(
            arcCenter: centerPoint,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeColor = circularBackgroundColor.cgColor

        progressLayer.path = path.cgPath
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.strokeEnd = _progress
    }

    // MARK: - Set Progress
    func setProgress(_ value: CGFloat, animated: Bool = true, duration: CFTimeInterval = 1.5) {
        let clamped = max(0, min(1, value))
        _progress = clamped

        let apply: () -> Void = {
            if animated {
                let animation = CABasicAnimation(keyPath: "strokeEnd")
                animation.fromValue = self.progressLayer.strokeEnd
                animation.toValue = clamped
                animation.duration = duration
                animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                self.progressLayer.strokeEnd = clamped
                self.progressLayer.add(animation, forKey: "progress")
            } else {
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                self.progressLayer.removeAllAnimations()
                self.progressLayer.strokeEnd = clamped
                CATransaction.commit()
            }
        }

        if Thread.isMainThread {
            apply()
        } else {
            DispatchQueue.main.async { apply() }
        }
    }

    func resetProgress() {
        _progress = 0
        progressLayer.removeAllAnimations()
        progressLayer.strokeEnd = 0
    }
}
