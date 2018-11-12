//
//  TheaterDetailViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/24.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import FSPagerView
import YouTubePlayer_Swift
import FirebaseDatabase
import Firebase
import Kingfisher
import Lottie

//swiftlint:disable file_length

protocol DataPassDelegate: AnyObject {
    func passData(data: TheaterInfo)
}

class TheaterDetailViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource, YouTubePlayerDelegate {
    
    var reachability = Reachability(hostName: "www.apple.com")
    
    func checkInternetFunction() -> Bool {
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            print("no internet connected.")
            return false
        } else {
            print("internet connected successfully.")
            return true
        }
    }
    
    func downloadData() {
        if checkInternetFunction() == false {
            
            internetLabel1.isHidden = false
            internetLabel2.isHidden = false
            
        } else {
            
            internetLabel1.isHidden = true
            internetLabel2.isHidden = true
            
        }
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        theaterDetailVideoView.alpha = 1
        theaterDetailPagerView.isHidden = true
        coverView.isHidden = true
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 67/255,
                                                                      green: 67/255,
                                                                      blue: 67/255,
                                                                      alpha: 1.0)

    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }

    weak var delegate: DataPassDelegate?
    
    var theaterDetail: TheaterInfo?
    
    @IBAction func playTrailer(_ sender: UIButton) {
        
        coverView.isHidden = false
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)

        if theaterDetailVideoView.isHidden == true {
            
            let imdbId = specificTheaterDetailData?.movie[pagerIndex].id
            
            theaterDetailTrailerManager.requestTrailerData(imdbId: imdbId ?? "tt3896198")
        }
        
        sender.isSelected = !sender.isSelected
        
        sender.setTitleColor(UIColor.white, for: .selected)
        
        if theaterDetailVideoView.ready && theaterDetailVideoView.isHidden == false {
            theaterDetailVideoView.pause()
            theaterDetailVideoView.isHidden = true
            theaterDetailPagerView.isHidden = false
            coverView.isHidden = true
            UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 67/255,
                                                                          green: 67/255,
                                                                          blue: 67/255,
                                                                          alpha: 1.0)

        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var theaterDetailVideoView: YouTubePlayerView!
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var internetLabel1: UILabel!
    @IBOutlet weak var internetLabel2: UILabel!
//    @IBOutlet weak var coverView: UIView!
    let coverView = UIView()

    @IBAction func toWebview(_ sender: Any) {
        performSegue(withIdentifier: "ToWebview", sender: self)
    }
    
    let imageNames = ["1", "2", "3", "4", "5"]
    let transformerTypes: [FSPagerViewTransformerType] = [.crossFading,
                                                          .zoomOut,
                                                          .depth,
                                                          .linear,
                                                          .overlap,
                                                          .ferrisWheel,
                                                          .invertedFerrisWheel,
                                                          .coverFlow,
                                                          .cubic]
    
    fileprivate var typeIndex = 4 {
        didSet {
            let type = self.transformerTypes[typeIndex]
            self.theaterDetailPagerView.transformer = FSPagerViewTransformer(type: type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.theaterDetailPagerView.itemSize = .zero // 'Zero' means fill the size of parent
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.theaterDetailPagerView.itemSize = self.theaterDetailPagerView.frame.size.applying(transform)
            case .ferrisWheel, .invertedFerrisWheel:
                self.theaterDetailPagerView.itemSize = CGSize(width: 180, height: 140)
            case .coverFlow:
                self.theaterDetailPagerView.itemSize = CGSize(width: 220, height: 170)
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.theaterDetailPagerView.itemSize = self.theaterDetailPagerView.frame.size.applying(transform)
            }
        }
    }
    
    @IBOutlet weak var showTimeTableView: UITableView!
    
    @IBOutlet weak var theaterDetailPagerView: FSPagerView! {
        didSet {
            self.theaterDetailPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
            
            theaterDetailPagerView.isInfinite = true

        }
    }
    
    var refref: DatabaseReference!

    var omdbData: OMDBData?
    
    var trailerData: TrailerData?
    
    var theaterDetailTrailerManager = TheaterDetailTrailerManager()
    
    var theaterDetailManager = TheaterDetailManager()
    
    let decoder = JSONDecoder()
    
    var theaterDtailDatas: [CinemaInfo] = []
    
    var specificTheaterDetailData: CinemaInfo?
    
    var trailerTag: Int = 0
    
    var postDict: [String: URL] = [:]
    
    var omdbDict: [String: OMDBData] = [:]
    
    var pagerIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let window = UIApplication.shared.keyWindow!
        coverView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        window.addSubview(coverView)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        coverView.isHidden = true
        
        downloadData()
        
        let centerX = UIScreen.main.bounds.width / 2
        let centerＹ = UIScreen.main.bounds.height / 2 - 70
        
        let loadingView = LOTAnimationView(name: "animation-w100-h100-2")
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 125, height: 125)
        loadingView.center = CGPoint(x: centerX, y: centerＹ)
        loadingView.contentMode = .scaleAspectFill
        
        loadingView.loopAnimation = true
        loadingView.animationSpeed = 0.5
        
        animationView.addSubview(loadingView)
        
        loadingView.play()

        title = theaterDetail?.name
        
        theaterDetailVideoView.delegate = self
        
        theaterDetailTrailerManager.delegate = self
        
        theaterDetailManager.delegate = self
        
        getFirebase()
        
    }
    
    func getFirebase() {
        refref = Database.database().reference()
        
        refref.child("cinema").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let value = snapshot.value else { return }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value) else { return }
            
            do {
                let theaterDetailData = try self.decoder.decode([CinemaInfo].self, from: jsonData)
                
                self.theaterDtailDatas = theaterDetailData
                
                for theaterDetailData in self.theaterDtailDatas where
                    theaterDetailData.name == self.theaterDetail?.name {
                        
                        self.specificTheaterDetailData = theaterDetailData
                        
                }
                
                self.getPoster()
                
                self.titleLabel.text = self.specificTheaterDetailData?.movie[self.pagerIndex].title
                self.releaseDateLabel.text = self.specificTheaterDetailData?.movie[self.pagerIndex].releaseDate
                self.ratedLabel.text = self.specificTheaterDetailData?.movie[self.pagerIndex].rated
                self.presentLabel.text = self.specificTheaterDetailData?.movie[self.pagerIndex].present
                self.languageLabel.text = self.specificTheaterDetailData?.movie[self.pagerIndex].language
                
            } catch {
                print(error)
            }
            
            self.animationView.isHidden = true
            
            self.downloadData()
            
            self.showTimeTableView.reloadData()

        }
    }
    
    func getPoster() {
        
        guard let movies = specificTheaterDetailData?.movie else {
            return
        }
        
        for movie in movies {
            
            theaterDetailManager.requestOMDBData(imdbId: movie.id )
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let index = self.typeIndex
        self.typeIndex = index // Manually trigger didSet
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return specificTheaterDetailData?.movie.count ?? 5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        
        guard let imdbId = specificTheaterDetailData?.movie[index].id else {
            return cell
        }
        
        cell.imageView?.kf.setImage(with: postDict[imdbId])
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        theaterDetailPagerView.deselectItem(at: index, animated: true)
        theaterDetailPagerView .scrollToItem(at: index, animated: true)
        
        pagerIndex = index
        
        self.getFirebase()
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
        print("pagerViewWillEndDragging")
        
        print(pagerView.currentIndex)
        
        let index = pagerView.currentIndex
        
        pagerIndex = index
    
        self.getFirebase()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailController = segue.destination as? WebviewViewController else {return}
        
        detailController.webDetail = theaterDetail
        
    }
}

extension TheaterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = specificTheaterDetailData?.movie[pagerIndex].showtime.count ?? 0
        
        print("-----------")
        print(count)
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let showtimeCell = showTimeTableView.dequeueReusableCell(
            withIdentifier: "ShowtimeCell",
            for: indexPath as IndexPath)
            as? ShowtimeTableViewCell else {
                return UITableViewCell()
        }
        print(pagerIndex)
        
        guard let date = specificTheaterDetailData?.movie[pagerIndex].showtime[indexPath.row].date  else {
            return UITableViewCell()
        }
        
        showtimeCell.dateLabel.text = date
        
        var showtimeString = ""
        let showtimeCount: Int = specificTheaterDetailData?.movie[pagerIndex].showtime[indexPath.row].time?.count ?? 5
        for index in 0 ... showtimeCount - 1 {
            
            guard let content = specificTheaterDetailData?.movie[pagerIndex].showtime[indexPath.row].time?[index] else {
                return UITableViewCell()
            }
            
            showtimeString += "\(content)   "
        }

        let attriString = NSMutableAttributedString(string: showtimeString)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 15
        style.minimumLineHeight = 0
        attriString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style,
                                 range: NSRange(location: 0, length: showtimeString.count))

        showtimeCell.showtimeLabel.attributedText = attriString
        
        return showtimeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func playTrailer() {
        let trailerKey = trailerData?.results[0].key
        
        theaterDetailVideoView.isHidden = false
        theaterDetailVideoView.loadVideoID(trailerKey ?? "QbOG7_vWFJE")
        
    }
}

extension TheaterDetailViewController: TheaterDetailManagerDelegate {
    func manager(_ manager: TheaterDetailManager, didGet products: OMDBData) {
        omdbData = products
        
        let posterUrl = URL(string: omdbData?.Poster ??
            "https://m.media-amazon.com/images/M/MV5BMTg2MzI1MTg3OF5BMl5BanBnXkFtZTgwNTU3NDA2MTI@._V1_SX300.jpg")
        
        postDict[omdbData?.imdbID ?? "tt3896198"] = posterUrl
        omdbDict[omdbData?.imdbID ?? "tt3896198"] = omdbData
        
        self.theaterDetailPagerView.reloadData()
        
        let imdbId = self.specificTheaterDetailData?.movie[self.pagerIndex].id
        
        self.enTitleLabel.text = self.omdbDict[imdbId ?? "tt3896198"]?.Title
        self.durationLabel.text = self.omdbDict[imdbId ?? "tt3896198"]?.Runtime
        self.genreLabel.text = self.omdbDict[imdbId ?? "tt3896198"]?.Genre
        self.genreLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func manager(_ manager: TheaterDetailManager, didFailWith error: Error) {
        print(error)
    }
    
}

extension TheaterDetailViewController: TheaterDetailTrailerManagerDelegate {
    func manager(_ manager: TheaterDetailTrailerManager, didGet products: TrailerData) {
        trailerData = products
        
        playTrailer()
    }
    
    func manager(_ manager: TheaterDetailTrailerManager, didFailWith error: Error) {
        print(error)
    }
    
}
