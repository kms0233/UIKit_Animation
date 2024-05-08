//
//  UIPanGestureViewController.swift
//  Animation
//
//  Created by 김민서 on 5/8/24.
//

import UIKit
import SnapKit
import Then

class UIPanGestureViewController: UIViewController {
    
    //점수
    var score: Int = 0
    
    //타이머
    var timer: Timer? = nil
    var isPause: Bool = true
    
    private lazy var chocoCat = UIImageView()
    private let topEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let bottomEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let leadingEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let trailingEnemy = UIImageView(image: UIImage(named: "enemy"))
    private let scoreLabel = UILabel().then {
        $0.textAlignment = .center
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setStyle()
        setLayout()
        makeEnemy()
        startTimer()
        
    }
    deinit {
        stopTimer() // 해당 뷰 컨트롤러가 메모리에서 해제될 때 타이머 중지
    }
    
    open func startTimer() {
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(self.enemyMove),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    open func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    func setStyle() {
        chocoCat.do {
            $0.image = UIImage(resource: .cat)
            $0.isUserInteractionEnabled = true
            //w제스처 추가
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(didImageViewMoved(_:)))
            $0.addGestureRecognizer(gesture)
        }
    }
    func setLayout() {
        [chocoCat,scoreLabel].forEach { [weak self] view in
            guard let self = self else { return }
            self.view.addSubview(view)
        }
        chocoCat.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
        
    }
    
    @objc private func enemyMove() {
        var topEnemyY = self.topEnemy.frame.origin.y
        topEnemyY += 10
        self.topEnemy.frame = .init(origin: .init(x: self.topEnemy.frame.origin.x,
                                                  y: topEnemyY),
                                    size: self.topEnemy.frame.size)
        
        var bottomEnemyY = self.bottomEnemy.frame.origin.y
        bottomEnemyY -= 10
        self.bottomEnemy.frame = .init(origin: .init(x: self.bottomEnemy.frame.origin.x,
                                                     y: bottomEnemyY),
                                       size: self.bottomEnemy.frame.size)
        
        var leadingEnemyX = self.leadingEnemy.frame.origin.x
        leadingEnemyX += 10
        self.leadingEnemy.frame = .init(origin: .init(x: leadingEnemyX,
                                                      y: self.leadingEnemy.frame.origin.y),
                                        size: self.leadingEnemy.frame.size)
        
        var trailingEnemyX = self.trailingEnemy.frame.origin.x
        trailingEnemyX -= 10
        self.trailingEnemy.frame = .init(origin: .init(x: trailingEnemyX,
                                                       y: self.trailingEnemy.frame.origin.y),
                                         size: self.trailingEnemy.frame.size)
        self.calculatePositionReached()
    }
    
    @objc private func didImageViewMoved(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: chocoCat)
        let changedX = chocoCat.center.x + transition.x
        let changedY = chocoCat.center.y + transition.y
        
        self.chocoCat.center = .init(x: changedX, y: changedY)
        //추가해줘~
        sender.setTranslation(.zero, in: self.chocoCat)
    }
    
    private func calculatePositionReached() {
        if self.chocoCat.frame.minX <= self.topEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.topEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.topEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.topEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.chocoCat.frame.minX <= self.leadingEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.leadingEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.leadingEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.leadingEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.chocoCat.frame.minX <= self.trailingEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.trailingEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.trailingEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.trailingEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.chocoCat.frame.minX <= self.bottomEnemy.frame.minX &&
            self.chocoCat.frame.maxX >= self.bottomEnemy.frame.maxX &&
            self.chocoCat.frame.minY <= self.bottomEnemy.frame.minY &&
            self.chocoCat.frame.maxY >= self.bottomEnemy.frame.maxY
        {
            self.scoreLabel.text = "Game End, Score:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
    }
    private func makeEnemy() {
        self.view.addSubview(topEnemy)
        self.view.addSubview(bottomEnemy)
        self.view.addSubview(leadingEnemy)
        self.view.addSubview(trailingEnemy)
        
        topEnemy.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        leadingEnemy.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        trailingEnemy.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        bottomEnemy.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
    
    
}




