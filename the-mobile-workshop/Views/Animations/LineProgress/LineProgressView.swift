//
//  LineProgressView.swift
//  the-mobile-workshop
//
//  Created by Le Tan Phat on 6/2/26.
//

import UIKit

class LineProgressView: UIView {

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private var _progress: CGFloat = 0.0
    private var lineHeight: CGFloat = 14.0
    private var lineBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.2)
    private var gradientColors: [UIColor] = []

    init(lineBackgroundColor: UIColor, gradientColors: [UIColor]) {
        self.lineBackgroundColor = lineBackgroundColor
        self.gradientColors = gradientColors
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear

        // Track
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        trackLayer.strokeColor = lineBackgroundColor.cgColor
        layer.addSublayer(trackLayer)

        // Gradient
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        layer.addSublayer(gradientLayer)

        // Progress (mask)
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.strokeEnd = 0
        gradientLayer.mask = progressLayer
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        updatePath()
    }

    private func updatePath() {
        let y = bounds.midY
        let inset = lineHeight / 2

        let path = UIBezierPath()
        path.move(to: CGPoint(x: inset, y: y))
        path.addLine(to: CGPoint(x: bounds.width - inset, y: y))

        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineHeight
        trackLayer.lineCap = .round

        progressLayer.path = path.cgPath
        progressLayer.lineWidth = lineHeight
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = _progress
    }

    // MARK: - Progress API
    func setProgress(_ value: CGFloat,
                     animated: Bool = false,
                     duration: CFTimeInterval = 1.5) {
        guard bounds.width > 0 else { return }
        let clamped = max(0, min(1, value))
        _progress = clamped
        progressLayer.removeAllAnimations()

        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progressLayer.strokeEnd
            animation.toValue = clamped
            animation.duration = duration
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            progressLayer.strokeEnd = clamped
            progressLayer.add(animation, forKey: "progress")
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            progressLayer.removeAllAnimations()
            progressLayer.strokeEnd = clamped
            CATransaction.commit()
        }
    }

    func resetProgress() {
        _progress = 0
        progressLayer.removeAllAnimations()
        progressLayer.strokeEnd = 0
    }
}
