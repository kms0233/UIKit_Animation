//
//  BezierPathViewController.swift
//  Animation
//
//  Created by 김민서 on 5/24/24.
//

import SnapKit
import UIKit
import Then

class BezierPathViewController: UIViewController {
    
    let progressView = ProgressView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100)))
    let imageView = UIImageView(image: UIImage(named: "cat"))
    let textLabel = UILabel().then {
        $0.text = "희희 내가 왔어 얘드라~!★"
        $0.font = UIFont.systemFont(ofSize: 24)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        setupLayout()
        progressView.animationCompletion = {
            self.showImageAndText()
        }
        progressView.progressAnimation(duration: 3, value: 1)
    }
    
    private func setupViews() {
        view.addSubview(progressView)
        view.addSubview(imageView)
        view.addSubview(textLabel)
        imageView.isHidden = true // 초기에는 이미지를 숨김
        textLabel.isHidden = true // 초기에는 텍스트도 숨김
    }
    
    private func setupLayout() {
        progressView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(300) // 이미지 크기 조정
        }
        textLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.top).offset(-10)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func showImageAndText() {
        UIView.transition(with: self.imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.imageView.isHidden = false
        }, completion: nil)
        
        UIView.transition(with: self.textLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.textLabel.isHidden = false 
        }, completion: nil)
    }
}
