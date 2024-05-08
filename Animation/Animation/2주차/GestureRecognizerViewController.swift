//
//  GestureRecognizerViewController.swift
//  Animation
//
//  Created by 김민서 on 5/8/24.
//


import UIKit
import SnapKit
import Then

class GestureRecognizerViewController: UIViewController {

    private lazy var chocoCat = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(chocoCat)
        setLayout()
        setStyle()

    }

    func setStyle() {
        chocoCat.do {
            $0.image = UIImage(resource: .cat)
            $0.isUserInteractionEnabled = true
            //w제스처 추가
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(didRedViewTapped)))
        }
    }
    func setLayout() {
        chocoCat.snp.makeConstraints {
            $0.top.equalToSuperview().inset(187)
            $0.leading.trailing.equalToSuperview().inset(101)
            $0.height.equalTo(240)
        }
    }

    
    @objc private func didRedViewTapped() {
        UIView.animate(withDuration: 1.0, delay: 0) {
            self.chocoCat.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            self.chocoCat.transform = .identity
        }
    }


}



