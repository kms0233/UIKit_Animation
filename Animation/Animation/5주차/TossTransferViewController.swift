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
    
    private let customKeypadView = CustomKeypadView()

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
        self.view.addSubviews(backButton, fromBankLabel, balanceLabel, toBankLabel, securityIcon, accountLabel, inputLabel, balanceButton)
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
        
        balanceButton.snp.makeConstraints {
            $0.top.equalTo(inputLabel.snp.bottom).offset(16)
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
    }
    
    func configureCustomKeypad() {
        customKeypadView.onNumberTapped = { [weak self] number in
            guard let self = self else { return }
            self.inputLabel.text = (self.inputLabel.text ?? "").replacingOccurrences(of: "원", with: "") + number + "원"
        }
        
        customKeypadView.onDeleteTapped = { [weak self] in
            guard let self = self else { return }
            var text = self.inputLabel.text?.replacingOccurrences(of: "원", with: "") ?? ""
            if !text.isEmpty {
                text.removeLast()
            }
            self.inputLabel.text = text.isEmpty ? "" : text + "원"
        }
        
        customKeypadView.onClearTapped = { [weak self] in
            self?.inputLabel.text = ""
        }
    }
}
