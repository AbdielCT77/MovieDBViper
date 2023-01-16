//
//  HomeNowPlayingTableViewCell.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 14/01/23.
//

import UIKit

class HomeNowPlayingTableViewCell: UITableViewCell {
    
    // MARK: - UIVariable -
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Variable -
    static let identifier = "HomeNowPlayingTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "HomeNowPlayingTableViewCell", bundle: nil)
    }
    var presenter: ViewToPresenterProtocol?
    var data: [MoviesModel] = []
    var navigationController: UINavigationController?
    var timer : Timer?
    var index = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(
            HomeNowPlayingCollectionViewCell.nib(),
            forCellWithReuseIdentifier: HomeNowPlayingCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureData(model: [MoviesModel]?) {
        data = model ?? []
        collectionView.reloadData()
        addTimer()
    }
    
    private func addTimer() {
        let timer1 = Timer(
            timeInterval: 5,
            target: self,
            selector: #selector(handleTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer1, forMode: RunLoop.Mode.common)
        self.timer = timer1
    }
    
    @objc private func handleTimer(){
        if data.count != 0 {
            index += 1
            index = index < self.data.count ? index : 0
            let indexPath = IndexPath(row: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
}

extension HomeNowPlayingTableViewCell: UICollectionViewDelegateFlowLayout,
                                        UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return data.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeNowPlayingCollectionViewCell.identifier,
            for: indexPath
        ) as? HomeNowPlayingCollectionViewCell {
            cell.configure(model: data[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
            return CGSize(width: 180, height: 290)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter?.showDetailMovieController(
            navigationController: self.navigationController ?? UINavigationController(),
            movie: data[indexPath.row].id ?? 0
        )
    }
    
    
}
