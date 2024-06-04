import UIKit
import SnapKit
import Then

final class TossTransferViewController: UIViewController {
    
    private let backButton = UIImageView(image: UIImage(resource: .backIcon))
    private let fromBankLabel = UILabel()
    private let balanceLabel = UILabel()
    private let toBankLabel = UILabel()
    private let securityIcon = UIImageView(image: UIImage(resource: .securityIcon))
    private let accountLabel = UILabel()
    private let inputLabel = UITextField()
    private let balanceButton = UIButton()
    private let alertLabel = UILabel()
    
    private let customKeypadView = CustomKeypadView()
    
    private let maxAmount: Int = 2000000
    
    private var currentInputAmount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setStyle()
        configureCustomKeypad()
    }
}

private extension TossTransferViewController {
    
    func setHierarchy() {
        self.view.addSubviews(backButton, fromBankLabel, balanceLabel, toBankLabel, securityIcon, accountLabel, inputLabel, balanceButton, alertLabel)
        inputLabel.addTarget(self, action: #selector(inputLabelDidChange), for: .editingChanged)
        inputLabel.addTarget(self, action: #selector(inputLabelDidBeginEditing), for: .editingDidBegin)
    }
    
    func setLayout() {
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.equalToSuperview().inset(7)
            $0.width.equalTo(34)
            $0.height.equalTo(34)
        }
        
        fromBankLabel.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(20)
        }
        
        balanceLabel.snp.makeConstraints {
            $0.top.equalTo(fromBankLabel.snp.bottom).offset(8)
            $0.leading.equalTo(fromBankLabel.snp.leading)
        }
        
        toBankLabel.snp.makeConstraints {
            $0.top.equalTo(balanceLabel.snp.bottom).offset(26)
            $0.leading.equalTo(fromBankLabel.snp.leading)
        }
        
        securityIcon.snp.makeConstraints {
            $0.top.equalTo(toBankLabel.snp.bottom).offset(20)
            $0.leading.equalTo(fromBankLabel.snp.leading)
            $0.width.equalTo(12)
            $0.height.equalTo(15)
        }
        
        accountLabel.snp.makeConstraints {
            $0.centerY.equalTo(securityIcon)
            $0.leading.equalTo(securityIcon.snp.trailing).offset(5)
        }
        
        inputLabel.snp.makeConstraints {
            $0.top.equalTo(securityIcon.snp.bottom).offset(43)
            $0.leading.equalTo(fromBankLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(5)
            $0.leading.equalTo(fromBankLabel)
        }
        
        balanceButton.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(5)
            $0.leading.equalTo(fromBankLabel)
            $0.width.equalTo(120)
            $0.height.equalTo(30)
        }
    }
    
    func setStyle() {
        self.view.backgroundColor = .white
        fromBankLabel.do {
            $0.text = "내 KB국민ONE통장-저축예금 계좌"
            $0.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        }
        
        balanceLabel.do {
            $0.text = "잔액 9,847원"
            $0.font = UIFont(name: "Pretendard-Medium", size: 14)
            $0.textColor = UIColor(named: "darkGray2")
        }
        
        toBankLabel.do {
            $0.text = "카카오뱅크로"
            $0.font = UIFont(name: "Pretendard-Bold", size: 20)
            $0.textColor = UIColor(named: "lightGray")
        }
        
        accountLabel.do {
            $0.text = "카카오뱅크 44447082464646"
            $0.font = UIFont(name: "Pretendard-Medium", size: 14)
            $0.textColor = UIColor(named: "lightGray2")
        }
        
        balanceButton.do {
            $0.backgroundColor = UIColor(named: "lightGray3")
            $0.setTitle("잔액 · 9,847원 입력", for: .normal)
            $0.setTitleColor(UIColor(named: "darkGray"), for: .normal)
            $0.titleLabel?.font = UIFont(name: "Pretendard-Semibold", size: 12.5)
            $0.layer.cornerRadius = 7
        }
        
        inputLabel.do {
            $0.font = UIFont(name: "Pretendard-Bold", size: 28)
            $0.backgroundColor = .none
            $0.textColor = UIColor(named: "darkGray")
            $0.placeholder = "얼마나 보낼까요?"
            $0.inputView = customKeypadView
            $0.autocorrectionType = .no
            $0.spellCheckingType = .no
        }
        
        alertLabel.do {
            $0.text = "한 번에 200만원까지 보낼 수 있어요."
            $0.font = UIFont(name: "Pretendard-Medium", size: 16)
            $0.textColor = .red
            $0.isHidden = true
        }
    }
    
    func configureCustomKeypad() {
        customKeypadView.onNumberTapped = { [weak self] number in
            guard let self = self else { return }
            
            var currentText = self.inputLabel.text?.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "") ?? ""
            currentText += number
            self.updateInputLabel(with: currentText)
            self.balanceButton.isHidden = true // 숫자 입력 시 balanceLabel 숨기기
        }
        
        customKeypadView.onDeleteTapped = { [weak self] in
            guard let self = self else { return }
            var text = self.inputLabel.text?.replacingOccurrences(of: "원", with: "").replacingOccurrences(of: ",", with: "") ?? ""
            if !text.isEmpty {
                text.removeLast()
            }
            self.updateInputLabel(with: text)
            self.balanceButton.isHidden = !text.isEmpty // 텍스트가 비어 있지 않으면 balanceLabel 숨기기
        }
        
        customKeypadView.onClearTapped = { [weak self] in
            self?.updateInputLabel(with: "")
            self?.balanceButton.isHidden = false // 클리어 시 balanceLabel 보이기
        }
    }
    
    
    //부르르 텍스트
    func shakeText() {
        self.inputLabel.transform = CGAffineTransform(translationX: 10, y: 10)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: [.curveEaseInOut]) {
            self.inputLabel.transform = .identity
        }
    }
    
    @objc func inputLabelDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            balanceButton.isHidden = true
        } else {
            balanceButton.isHidden = false
        }
    }
    
    @objc func inputLabelDidBeginEditing(_ textField: UITextField) {
        balanceButton.isHidden = true
    }
}

private extension TossTransferViewController {
    //숫자 입력시 드롭되는 애니메이션
    func insertNumberAnimation(_ numberView: UILabel) {
        numberView.transform = CGAffineTransform(translationX: 0, y: -40)
        numberView.isHidden = false
        numberView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            numberView.transform = CGAffineTransform(translationX: 0, y: 0)
            numberView.alpha = 1.0
        }, completion: nil)
    }
    
    func updateInputLabel(with text: String) {
        let amount = Int(text.replacingOccurrences(of: ",", with: "").replacingOccurrences(of: "원", with: "")) ?? 0
        if amount > maxAmount {
            self.alertLabel.isHidden = false // 입력 제한 시 alertLabel 보이기
            shakeText() // 입력 제한 초과 시 흔들림 애니메이션 호출
            return
        } else {
            self.alertLabel.isHidden = true // 입력 제한이 해제되면 alertLabel 숨기기
            self.inputLabel.textColor = UIColor(named: "darkGray")
        }
        self.inputLabel.text = amount.formattedWithSeparator + "원"
        self.currentInputAmount = amount
        
        // 애니메이션 추가 부분
        animateLastNumber()
    }
    
    func animateLastNumber() {
        guard let text = inputLabel.text, let lastCharacter = text.filter({ $0.isNumber }).last else { return }
        
        // 마지막 숫자에 대한 레이블 생성
        let label = UILabel()
        label.text = String(lastCharacter)
        label.font = inputLabel.font
        label.textColor = inputLabel.textColor
        label.textAlignment = .center
        self.view.addSubview(label)
        
        // 레이블 위치 설정
        label.snp.makeConstraints {
            $0.centerY.equalTo(inputLabel.snp.centerY)
            $0.leading.equalTo(inputLabel.snp.leading).offset(-5) // 텍스트 필드의 왼쪽에 위치하도록 설정하고 여유 공간을 줍니다.
        }
        
     
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            label.transform = CGAffineTransform(translationX: 0, y: -40)
            label.alpha = 0
        }) { _ in
            label.removeFromSuperview() // 애니메이션이 끝나면 레이블을 제거합니다.
        }
    }

    
}
