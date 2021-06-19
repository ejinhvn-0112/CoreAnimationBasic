//
//  ViewController.swift
//  CoreAnimation
//
//  Created by 김은중 on 2021/06/19.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    let _width: CGFloat = 40
    let _height: CGFloat = 40
    
    let redCircle = UIImageView()
    let _diameter: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView.backgroundColor = .systemRed
        
        view.addSubview(redView)
        view.addSubview(redCircle)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        redView.frame = CGRect(x: view.bounds.midX,
//                               y: view.bounds.midY,
//                               width: _width, height: _height)
        
        redView.frame = CGRect(x: view.bounds.midX - _width/2,
                               y: view.bounds.midY - _height/2,
                               width: _width, height: _height)
        
        redCircle.frame = CGRect(x: view.bounds.midX - _diameter/2,
                                 y: view.bounds.midY - _diameter/2,
                                 width: _diameter, height: _diameter)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: _diameter, height: _diameter))
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: _diameter, height: _diameter)
            
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.cgContext.setFillColor(UIColor.clear.cgColor)
            ctx.cgContext.setLineWidth(1)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        redCircle.image = img
        
        
        roundcircleanimate()
    }
    
    /// 사각형이 왼쪽에서 오른쪽으로 이동하는 애니메이션
    func animate() {
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 20 + 140/2
        animation.toValue = 300
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.position = CGPoint(x: 300, y: 100 + 100/2)
    }
    
    /// 사각형이 커지는 애니메이션
    func scaleanimate() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.4
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeScale(2, 2, 1)
    }
    
    /// 사각형이 돌아가는 애니메이션
    func rotateanimate() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 4
        animation.duration = 1
        
        redView.layer.add(animation, forKey: "basic")
        redView.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
    }
    
    /// 사각형이 흔들리는 애니메이션
    func shakeanimate() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        redView.layer.add(animation, forKey: "shake")
    }
    
    /// 사각형이 원을따라 돌아가는 애니메이션
    func roundcircleanimate() {
        let boundingRect = CGRect(x: -_diameter/2, y: -_diameter/2, width: _diameter, height: _diameter)
        
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 2
        orbit.isAdditive = true
        orbit.calculationMode = CAAnimationCalculationMode.paced
        orbit.rotationMode = CAAnimationRotationMode.rotateAuto
        
        redView.layer.add(orbit, forKey: "redbox")
    }


}

