//
//  ViewController.swift
//  CAFilter-Test
//
//  Created by Seb Vidal on 15/02/2024.
//

import UIKit

class ViewController: UIViewController {
    var circleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView = UIView()
        circleView.backgroundColor = .systemTeal
        circleView.layer.cornerRadius = 100
        circleView.layer.cornerCurve = .circular
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 200),
            circleView.heightAnchor.constraint(equalToConstant: 200),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
        ])
        
        let gaussianBlur = CAFilter(type: "gaussianBlur")
        gaussianBlur.setValue(50, forKey: "inputRadius")
        
        circleView.layer.filters = [gaussianBlur]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let animation = CABasicAnimation(keyPath: "filters.gaussianBlur.inputRadius")
        animation.toValue = 0
        animation.fromValue = 50
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        circleView.layer.add(animation, forKey: nil)
        circleView.layer.setValue(0, forKeyPath: "filters.gaussianBlur.inputRadius")
    }
}

func CAFilter(type: String) -> NSObject {
    let filter = (NSClassFromString("CAFilter") as! NSObject.Type)
        .perform(NSSelectorFromString("alloc"))
        .takeUnretainedValue()
        .perform(NSSelectorFromString("initWithType:"), with: type)
        .takeUnretainedValue()
    
    return filter as! NSObject
}
