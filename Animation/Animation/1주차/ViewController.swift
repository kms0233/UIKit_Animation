import UIKit
import SnapKit

class ViewController: UIViewController {
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    private let label1: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "long text \n\n text \n\n\n text \n\n text \n text \n\n\n texttexttext"
        label.textColor = .black
        return label
    }()
    private let label2: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "long text \n\n text \n\n\n text \n\n text \n text \n\n\n texttexttext \n\n\n\n text \n\n\n\n\n\n\n text \n\n\n\n\n\n\n\n\n\n text \n\n\n\n \n\n\n\n \n\n\n\n \n\n\n\n text"
        label.textColor = .black
        return label
    }()
    
    // 1. sticky할 뷰와 동일한 형태 뷰 준비 + 숨김 상태로 초기화
        private let stickyHeaderView: UIView = {
            let view = UIView()
            view.backgroundColor = .green
            view.isHidden = true
            return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        view.addSubview(topView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(label2)
        
        view.addSubview(stickyHeaderView)
        
        topView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(120)
        }

        stackView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        headerView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        // 3. scrollView의 top은 topView의 하단에 붙이기 (topView의 하단에 sticky도 붙일것)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.bottom.right.equalToSuperview()
        }

        // 4. sticky 뷰는 topView하단에 붙이기 + stikcy의 높이는 sticky할 뷰의 높이와 동일하게 설정
        stickyHeaderView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(56)
        }
        
        scrollView.delegate = self
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y: 손가락을 위로 올리면 + 값, 손가락을 아래로 내리면 - 값
        print(scrollView.contentOffset.y, headerView.frame.minY)
        
        // 5. 핵심 - frame.minY를 통해 sticky 타이밍을 계산
        let shouldShowSticky = scrollView.contentOffset.y >= headerView.frame.minY
        stickyHeaderView.isHidden = !shouldShowSticky
    }
}
