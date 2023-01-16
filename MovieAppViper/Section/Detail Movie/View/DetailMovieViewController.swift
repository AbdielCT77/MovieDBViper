//
//  DetailMovieViewController.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import UIKit
import youtube_ios_player_helper

class DetailMovieViewController: UIViewController {
    
    // MARK: - UI Variable -
    
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var backdropImageView: UIView!
    @IBOutlet weak var playTrailerBtn: UIButton!
    @IBOutlet weak var playerVIew: YTPlayerView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var genreLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var movieDescLbl: UILabel!
    @IBOutlet var socialMediaButton: [UIButton]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Variable -
    var dataDetail: DetailMovieResponse?
    var presenter: DetailMovieViewToPresenterProtocol?
    var movieId: Int?
    private var youtubeKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchDetail()
    }
    
    private func setupCollectionView(){
        
    }
    
    private func fetchDetail(){
        if let id = movieId {
            presenter?.fetchMovieDetail(movieId: id)
        }
    }
    
    private func setUI(){
        guard let dataDetail = dataDetail else { return }
        self.movieTitleLbl.text = dataDetail.title
        self.movieDescLbl.text = dataDetail.overview
        self.ratingLbl.text = "\(dataDetail.voteAverage)"
        let genres = dataDetail.genres ?? []
        playTrailerBtn.addTarget(
            self,
            action: #selector(watchTrailerTapped),
            for: .touchUpInside
        )
        var gen = ""
        for (index, genre) in genres.enumerated() {
            gen = (index+1 == genres.count) ?
            gen + (genre.name ?? "") : gen + (genre.name ?? "") + ", "
        }
        genreLbl.text = gen
        if(dataDetail.videos != nil && dataDetail.videos?.results != nil) {
            for videoid in dataDetail.videos!.results! {
                if videoid.site == "YouTube" &&
                    videoid.type == "Trailer" &&
                    (videoid.key != "" || videoid.key != nil)
                {
                    youtubeKey = videoid.key ?? ""
                    print("video key : ", videoid.key ?? "video key is null")
                    break
                }
            }
        }
        
        for i in 0..<socialMediaButton.count {
            if i == 0 { //link
                socialMediaButton[i].isHidden = dataDetail.homepage == ""
                socialMediaButton[i].addTarget(
                    self,
                    action: #selector(linkBtntapped(_:)),
                    for: .touchUpInside
                )
            }
            if i == 1 { //insta
                socialMediaButton[i].isHidden = dataDetail.externalIds?.instagramId == ""
                socialMediaButton[i].addTarget(
                    self,
                    action: #selector(instagramBtnTapped(_:)),
                    for: .touchUpInside
                )
            }
            if i == 2 { // fb
                socialMediaButton[i].isHidden = dataDetail.externalIds?.facebookId == ""
                socialMediaButton[i].addTarget(
                    self,
                    action: #selector(facebookBtnTapped(_:)),
                    for: .touchUpInside
                )
            }
            if i == 3 { // twitter
                socialMediaButton[i].isHidden = dataDetail.externalIds?.twitterId == ""
                socialMediaButton[i].addTarget(
                   self,
                   action: #selector(twitterBtnTapped(_:)),
                   for: .touchUpInside
               )
            }
        }
        
        if let path = dataDetail.backdropPath {
            guard let urlImage = URL(
                string: GlobalVariables.urlImage.appending(path)
            ) else { return }
            self.backDropImage.loadImageSDWeb(url: urlImage)
        }
    }
    
    @objc func linkBtntapped(_ sender: Any) {
        openSocialMedia(
            appUrl: URL(string: dataDetail?.homepage ?? "")!,
            urlString: ""
        )
    }
    
    @objc func instagramBtnTapped(_ sender: Any) {
        openSocialMedia(
            appUrl: URL(
                string: "instagram://user?username=" + (dataDetail?.externalIds?.instagramId ?? "")
            )!,
            urlString: "https://instagram.com/" + (dataDetail?.externalIds?.instagramId ?? "")
        )
    }
    
    @objc func facebookBtnTapped(_ sender: Any) {
        openSocialMedia(
            appUrl: URL(
                string: "fb://profile/" + (dataDetail?.externalIds?.facebookId ?? "")
            )!,
            urlString: "https://facebook.com/" + (dataDetail?.externalIds?.facebookId ?? "")
        )
    }
    
    @objc func twitterBtnTapped(_ sender: Any) {
        openSocialMedia(
            appUrl: URL(
                string: "twitter://user?screen_name=" + (dataDetail?.externalIds?.twitterId ?? "")
            )!,
            urlString: "https://twitter.com/" + (dataDetail?.externalIds?.twitterId ?? "")
        )
    }

    
    func openSocialMedia(appUrl: URL , urlString: String){
        let application = UIApplication.shared
        if application.canOpenURL(appUrl) {
            application.open(appUrl)
        } else {
            let webURL = URL(string: urlString)!
            application.open(webURL)
        }
    }

}

extension DetailMovieViewController: DetailMoviePresenterToViewProtocol {
    func showMovieDetail(data: DetailMovieResponse?) {
        guard let detail = data else { return }
        dataDetail = detail
        setUI()
    }
    
    func showError(error: BaseError) {
        print("ini error", error.getError.getDesc())
    }
    
    func isLoading(isLoading: Bool) {
        print("ini loading", isLoading)
    }
    
}

extension DetailMovieViewController: YTPlayerViewDelegate{
    @objc func watchTrailerTapped() {
        if youtubeKey != "" {
            delegateYT()
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    private func delegateYT(){
        playerVIew.isHidden = false
        backdropImageView.isHidden = true
        playerVIew.delegate = self
        playerVIew.load(
            withVideoId: youtubeKey
        )
    }
}