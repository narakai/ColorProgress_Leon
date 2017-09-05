//
//  ColorProgress.swift
//  ColorProgress_Leon
//
//  Created by lai leon on 2017/9/5.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

class ColorProgress: UIView {

    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.borderColor = UIColor.white.cgColor
        gradientLayer.borderWidth = 1.0
        var colors = [CGColor]()
        for hue in stride(from: 0, through: 360, by: 5) {
            let color = UIColor(hue: CGFloat(hue) / 360.0, saturation: 1.0, brightness: 1.0, alpha: 1).cgColor
            colors.append(color)
        }
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()

    let maskLayer: CALayer = {
        let maskLayer = CALayer()
        maskLayer.backgroundColor = UIColor.white.cgColor
        return maskLayer
    }()

    let whiteBG: CALayer = {
        let whiteBG = CALayer()
        whiteBG.borderColor = UIColor.white.cgColor
        whiteBG.borderWidth = 1.0
        return whiteBG
    }()

    let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "colors")
        animation.duration = 0.08
        animation.fillMode = kCAFillModeForwards
        return animation
    }()

    var progress: CGFloat = 0.0 {
        didSet {
            changeMaskFrame()
        }
    }

    private func changeMaskFrame() {
        maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: progress*bounds.size.width, height: bounds.size.height)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    private func setupView() {
        whiteBG.frame = bounds
        whiteBG.cornerRadius = bounds.size.height / 2.0
        layer.addSublayer(whiteBG)

        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.size.height / 2.0
        layer.addSublayer(gradientLayer)

        //添加显示区域
        changeMaskFrame()
        maskLayer.cornerRadius = bounds.size.height / 2.0
        gradientLayer.mask = maskLayer

        performAnimation()
    }

    func performAnimation() {
        var colors = gradientLayer.colors
        let color = colors?.popLast() as! CGColor
        colors?.insert(color, at: 0)
        animation.toValue = colors
        animation.delegate = self
        gradientLayer.add(animation, forKey: "gradient")
        gradientLayer.colors = colors
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ColorProgress: CAAnimationDelegate {
    //动画停止后继续动画
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        performAnimation()
    }
}


