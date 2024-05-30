import SnapKit
import UIKit
import Then

class CarouselViewController: UIViewController {
    private let titleLabel = UIImageView(image: UIImage(named: "image"))
    private let imagePathArray: [String] = ["image6", "image1", "image2", "image3", "image4", "image5", "image6", "image1"]
    private let starLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "★★★★★★"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 60) // 텍스트 사이즈를 24로 설정
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        self.setCollectionViewConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Move to the second item (index 1) to show the first image properly in infinite scroll
        self.collectionView.setContentOffset(.init(x: UIScreen.main.bounds.width, y: 0), animated: false)
    }
    
    private func setLayout() {
        self.view.addSubview(collectionView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(starLabel)
        
        self.view.backgroundColor = .white
        collectionView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(447)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(262)
            $0.height.equalTo(43)
        }
        starLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    private func setCollectionViewConfig() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CarouselCollectionViewCell.self,
                                     forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 447)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        self.collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.contentInsetAdjustmentBehavior = .never
        $0.isPagingEnabled = true
    }
}

extension CarouselViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.x
        let pageWidth = UIScreen.main.bounds.width
        let currentPage = Int(currentOffset / pageWidth)
        
        if currentPage == 0 {
            let offsetX = CGFloat(imagePathArray.count - 2) * pageWidth
            scrollView.setContentOffset(.init(x: offsetX, y: 0), animated: false)
        } else if currentPage == imagePathArray.count - 1 {
            let offsetX = pageWidth
            scrollView.setContentOffset(.init(x: offsetX, y: 0), animated: false)
        }
    }
}

extension CarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePathArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageName = imagePathArray[indexPath.row]
        cell.bindImageData(imageName)
        
        return cell
    }
}
