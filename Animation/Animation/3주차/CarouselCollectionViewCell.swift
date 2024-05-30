import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CarouselCollectionViewCell"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    private func setLayout() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    internal func bindImageData(_ imageName: String) {
        self.imageView.image = UIImage(named: imageName)
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
}
