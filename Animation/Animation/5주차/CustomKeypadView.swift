import UIKit
import SnapKit

class CustomKeypadView: UIView {
    
    var onNumberTapped: ((String) -> Void)?
    var onDeleteTapped: (() -> Void)?
    var onClearTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeypad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupKeypad() {
        let buttonTitles = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["00", "0", "⌫"]
        ]
        
        self.backgroundColor = .white
        
        let keypadStackView = UIStackView()
        keypadStackView.axis = .vertical
        keypadStackView.distribution = .equalSpacing
        keypadStackView.alignment = .center
        keypadStackView.spacing = 20
        addSubview(keypadStackView)
        
        keypadStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(46)
            $0.leading.trailing.equalToSuperview()
        }
        
        for row in buttonTitles {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .equalSpacing
            rowStackView.alignment = .center
            rowStackView.spacing = 20
            keypadStackView.addArrangedSubview(rowStackView)
            
            for title in row {
                let button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.setTitleColor(.darkGray, for: .normal)
                button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 28)
                button.backgroundColor = .none
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                rowStackView.addArrangedSubview(button)
                
                button.snp.makeConstraints {
                    $0.width.equalTo(104)
                    $0.height.equalTo(47)
                }
            }
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(346)  // 4 rows * 80 height + 3 * 10 padding
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        switch title {
        case "⌫":
            onDeleteTapped?()
        default:
            onNumberTapped?(title+"")
        }
    }
}
