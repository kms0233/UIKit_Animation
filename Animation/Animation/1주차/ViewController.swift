import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
    private let catImage = UIImageView()
    private lazy var button = UIButton()
    private var buttonTapCount = 0 //버튼 눌린 횟수

    private func setLayout() {
        [catImage, button].forEach { [weak self] view in
            guard let self = self else { return }
            self.view.addSubview(view)
        }

        catImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(187)
            $0.leading.equalToSuperview().inset(101)
            $0.trailing.equalToSuperview().inset(101)
            $0.width.equalTo(188)
            $0.height.equalTo(240)
        }
        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(65)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setStyle()

        // 버튼에 액션 추가
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    func setStyle() {
        catImage.do {
            $0.image = UIImage(resource: .cat)
        }
        button.do {
            $0.backgroundColor = .black
            $0.setTitle("날 눌러줘!", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 3
        }
    }

    // 버튼이 눌렸을 때 호출되는 액션
    @objc private func buttonTapped() {
        buttonTapCount += 1 // 버튼이 눌린 횟수 증가

        var toastMessage = ""
        
        if (buttonTapCount == 1 ){
            toastMessage = "안녕 반가워~~나는 초코캣"
        }
        else if (buttonTapCount == 2){
            toastMessage = "우리 친하게 지내자!!"
        }
        else if (buttonTapCount == 3){
            toastMessage = "나 이제 혼자 있고 싶은데"
        }
        else {
            toastMessage = "그만 괴롭혀라~^^"
        }
        showToast(title: toastMessage)
        button.shakeButton()
    }
    
    //토스트 메세지 띄우기
    private func showToast(title: String) {
        guard let rootView = UIApplication.shared.windows.first else { return }
        
        let toastView = ToastView(title: title)
        rootView.addSubview(toastView)
        
        toastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(100)
            $0.height.equalTo(45)
        }
        
        toastView.layer.cornerRadius = 10
        UIView.animate(withDuration: 2.0) {
            toastView.alpha = 0
        } completion: { _ in
            toastView.removeFromSuperview()
        }
    }
}



class ToastView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //title을 받아서 초기화
    init(title: String) {
        super.init(frame: .zero)
        self.backgroundColor = .black
        self.setLayout()
        self.titleLabel.text = title
    }
    //텍스트 설정
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private func setLayout() {
        self.backgroundColor = .gray
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(15)
        }
    }
}

extension UIButton {
    func shakeButton() {
        self.transform = CGAffineTransform(translationX: 0, y: 20) //y축으로 20만큼 움직일거임
        UIView.animate(withDuration: 0.3,//0.3초 동안 지속 ~
                       delay: 0,
                       //스프링 애니메이션의 감쇠 비율을 설정
                       //값이 작을수록 스프링이 더 강하게 튕김
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 1, //스프링 애니메이션의 초기 속도를 설정
                       options: [.curveEaseInOut]) { //애니메이션이 시작과 끝 부분에서 부드럽게 변화시켜줌
            self.transform = .identity //에니메이션이 완료된 후에 버튼의 변형을 원래대로 되돌리는 역할
        }
    }
}
