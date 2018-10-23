//
//  ViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/19.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

//swiftlint:disable file_length

import UIKit
import WKAwesomeMenu
import FSPagerView
import YouTubePlayer_Swift
import FirebaseDatabase
import Firebase
import Kingfisher
import Crashlytics
import Lottie

class InTheaterViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, YouTubePlayerDelegate {
    
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
        
        videoView.alpha = 1
        inTheaterPagerView.isHidden = true
        coverView.isHidden = true

    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    
    @IBOutlet weak var videoView: YouTubePlayerView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showtimeController = segue.destination as? MovieShowtimeViewController else {return}
        
        showtimeController.firebaseMovieData = inTheaterDatas[pagerIndex]
        
    }

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
            self.inTheaterPagerView.transformer = FSPagerViewTransformer(type: type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.inTheaterPagerView.itemSize = .zero // 'Zero' means fill the size of parent
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.inTheaterPagerView.itemSize = self.inTheaterPagerView.frame.size.applying(transform)
            case .ferrisWheel, .invertedFerrisWheel:
                self.inTheaterPagerView.itemSize = CGSize(width: 180, height: 140)
            case .coverFlow:
                self.inTheaterPagerView.itemSize = CGSize(width: 220, height: 170)
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.inTheaterPagerView.itemSize = self.inTheaterPagerView.frame.size.applying(transform)
            }
        }
    }
    
    @IBOutlet weak var infoTableView: UITableView!
    
    @IBOutlet weak var animationView: UIView!
    
    @IBOutlet weak var inTheaterPagerView: FSPagerView! {
        didSet {
            self.inTheaterPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
            
            inTheaterPagerView.isInfinite = true
        }
    }
    
    var refref: DatabaseReference!
    
    var omdbData: OMDBData?
    
    var trailerData: TrailerData?
    
    var inTheaterTrailerManager = InTheaterTrailerManager()
    
    var inTheaterManager = InTheaterManager()
    
    let decoder = JSONDecoder()
    
    var inTheaterDatas: [MovieInfo] = []
    
    var trailerTag: Int = 0
    
    var postDict: [String: URL] = [:]
    
    var omdbDict: [String: OMDBData] = [:]
    
    var pagerIndex: Int = 0
    
    @IBOutlet weak var internetLabel1: UILabel!
    @IBOutlet weak var internetLabel2: UILabel!
    @IBOutlet weak var coverView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        setNavigationBarItem()
        
        self.inTheaterPagerView.dataSource = self
        self.inTheaterPagerView.delegate = self
        
        let infoNibs = UINib(nibName: "MovieInfoTableViewCell", bundle: nil)
        infoTableView.register(infoNibs, forCellReuseIdentifier: "InfoCell")
        
        videoView.delegate = self
        
        inTheaterTrailerManager.delegate = self
        
        inTheaterManager.delegate = self
        
        refref = Database.database().reference()
        
        refref.child("InTheater").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let value = snapshot.value else { return }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value) else { return }
            
            do {
                let inTheaterData = try self.decoder.decode([MovieInfo].self, from: jsonData)
                print(inTheaterData)
                
                self.inTheaterDatas = inTheaterData
                
                self.getPoster()
                
            } catch {
                print(error)
            }
            
            self.downloadData()
            
            self.animationView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let index = self.typeIndex
        self.typeIndex = index // Manually trigger didSet
    }
    
    @objc func menu() {
        self.openSideMenu()
    }
    
    func setNavigationBarItem() {
        
        //沒有下面兩行navigationbar會有分隔線
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let menuButton = UIButton()
        menuButton.setImage(#imageLiteral(resourceName: "listing-option.png"), for: .normal)
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let leftButton = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = leftButton
        leftButton.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        leftButton.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
        menuButton.addTarget(self, action: #selector(InTheaterViewController.menu), for: .touchUpInside)

    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return inTheaterDatas.count
        
    }
    
    func getPoster() {
        
        for inTheaterData in inTheaterDatas {
            
            inTheaterManager.requestOMDBData(imdbId: inTheaterData.id ?? "tt3896198")
        }
        
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        
        guard let imdbId = inTheaterDatas[index].id else {
            return cell
        }
        
        cell.imageView?.kf.setImage(with: postDict[imdbId])
    
        return cell
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        inTheaterPagerView.deselectItem(at: index, animated: true)
        inTheaterPagerView .scrollToItem(at: index, animated: true)
        
        pagerIndex = index

        infoTableView.reloadData()
    }

    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
        print("pagerViewWillEndDragging")
    
        print(pagerView.currentIndex)
        
        let index = pagerView.currentIndex
        
        pagerIndex = index
        
        infoTableView.reloadData()
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
    }

}

extension InTheaterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let infoCell = infoTableView.dequeueReusableCell(
            withIdentifier: "InfoCell",
            for: indexPath as IndexPath)
            as? MovieInfoTableViewCell else {
                return UITableViewCell()
        }
        
        infoCell.trailerButton.addTarget(self, action: #selector(playTrailer(sender:)), for: .touchUpInside)
        
        guard inTheaterDatas.count > 0 else { return infoCell }
        
        // firebase data
        
        infoCell.titleLabel.text = inTheaterDatas[pagerIndex].title
        infoCell.ratedLabel.text = inTheaterDatas[pagerIndex].rated
        infoCell.releaseDateLabel.text = inTheaterDatas[pagerIndex].releaseDate
        
        let imdbId = inTheaterDatas[pagerIndex].id
    
        // omdb data
        
        infoCell.enTitleLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Title
        infoCell.durationLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Runtime
        infoCell.genreLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Genre
        infoCell.imdbRatingLabel.text = omdbDict[imdbId ?? "tt3896198"]?.imdbRating
        infoCell.directorLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Director
        infoCell.actorLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Actors
        infoCell.plotLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Plot
        infoCell.showtimeButton.addTarget(self, action: #selector(toShowtime(sender:)), for: .touchUpInside)

        return infoCell
    }
    
    @objc func toShowtime(sender: UIButton) {
        self.performSegue(withIdentifier: "InTheaterToShowtime", sender: self)
    }
    
    @objc func playTrailer(sender: UIButton) {
        
        coverView.isHidden = false
        
        // get indexpath of the cell
        
//        guard let cell = sender.superview?.superview as? MovieInfoTableViewCell else { return }
//        guard let indexPath = infoTableView.indexPath(for: cell) else { return }
        
        if videoView.isHidden == true {
            
            let imdbId = inTheaterDatas[pagerIndex].id
            
            inTheaterTrailerManager.requestTrailerData(imdbId: imdbId ?? "tt3896198")
        }
        
        sender.isSelected = !sender.isSelected
    
        sender.setTitleColor(UIColor.white, for: .selected)

        if videoView.ready && videoView.isHidden == false {
            videoView.pause()
            videoView.isHidden = true
            inTheaterPagerView.isHidden = false
            coverView.isHidden = true
        }
    
    }
    
    func playTrailer() {
        let trailerKey = trailerData?.results[0].key
    
        videoView.isHidden = false
        videoView.loadVideoID(trailerKey ?? "QbOG7_vWFJE")
        
    }
}

extension InTheaterViewController: InTheaterManagerDelegate {
    func manager(_ manager: InTheaterManager, didGet products: OMDBData) {
        omdbData = products
        
        let posterUrl = URL(string: omdbData?.Poster ??
            "https://m.media-amazon.com/images/M/MV5BMTg2MzI1MTg3OF5BMl5BanBnXkFtZTgwNTU3NDA2MTI@._V1_SX300.jpg")
        
        postDict[omdbData?.imdbID ?? "tt3896198"] = posterUrl
        omdbDict[omdbData?.imdbID ?? "tt3896198"] = omdbData
        
        self.inTheaterPagerView.reloadData()
        self.infoTableView.reloadData()
    }
    
    func manager(_ manager: InTheaterManager, didFailWith error: Error) {
        print(error)
    }
    
}

extension InTheaterViewController: InTheaterTrailerManagerDelegate {
    func manager(_ manager: InTheaterTrailerManager, didGet products: TrailerData) {
        trailerData = products
        
        playTrailer()
    }
    
    func manager(_ manager: InTheaterTrailerManager, didFailWith error: Error) {
        print(error)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }}
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }}
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
}

extension UILabel {
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            } else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern,
                                                                  at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            } else {
                return 0
            }
        }
    }
}
