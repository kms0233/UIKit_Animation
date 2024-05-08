//
//  TransformViewController.swift
//  Animation
//
//  Created by 김민서 on 4/25/24.
//

import UIKit
import SnapKit
import Then

class TransformViewController: UIViewController {

    private var squareFrame: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 100, y:100, width: 100, height: 100)
        view.backgroundColor = .systemPink
        return view
    }()
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
   
        self.view.addSubview(squareFrame)
        didMoveSquareLeft()
    }


    //square를 왼쪽으로 움직이는 함수
    private func didMoveSquareLeft() {
        //몇초동안 2.0초 동안 애니메이션을 지속하겠다!
        UIView.animate(withDuration: 2.0) {
            self.squareFrame.transform = CGAffineTransform(translationX: -50, y: 0)//-50 즉 왼쪽으로 50만큼!
        }
    }
   
}



