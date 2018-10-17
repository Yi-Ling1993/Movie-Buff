//
//  SoonViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/28.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import FSPagerView
import YouTubePlayer_Swift
import FirebaseDatabase
import Firebase
import Kingfisher
import Lottie

class SoonViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource, YouTubePlayerDelegate {
    
    var reachability = Reachability(hostName: "www.apple.com")
    
    func checkInternetFunction() -> Bool {
        if reachability?.currentReachabilityStatus().rawValue == 0 {
            print("no internet connected.")
            return false
        }else {
            print("internet connected successfully.")
            return true
        }
    }
    
    func downloadData() {
        if checkInternetFunction() == false {
            
            internetLabel1.isHidden = false
            internetLabel2.isHidden = false
            
        }else {
            
            internetLabel1.isHidden = true
            internetLabel2.isHidden = true
            
        }
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        
        soonVideoView.alpha = 1
        soonPagerView.isHidden = true
        coverView.isHidden = true

    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    
    
    let imageNames = ["1","2","3","4","5"]
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
            self.soonPagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.soonPagerView.itemSize = .zero // 'Zero' means fill the size of parent
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.soonPagerView.itemSize = self.soonPagerView.frame.size.applying(transform)
            case .ferrisWheel, .invertedFerrisWheel:
                self.soonPagerView.itemSize = CGSize(width: 180, height: 140)
            case .coverFlow:
                self.soonPagerView.itemSize = CGSize(width: 220, height: 170)
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.soonPagerView.itemSize = self.soonPagerView.frame.size.applying(transform)
            }
        }
    }

    @IBOutlet weak var soonInfoTableView: UITableView!
    @IBOutlet weak var soonPagerView: FSPagerView! {
        didSet {
            self.soonPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
            
            soonPagerView.isInfinite = true

        }
    }
    
    @IBOutlet weak var soonVideoView: YouTubePlayerView!
    
    @IBOutlet weak var coverView: UIView!
    
    
    var refref: DatabaseReference!
    
    var soonTrailerManager = SoonTrailerManager()
    
    var soonManager = SoonManager()
    
    let decoder = JSONDecoder()
    
    var soonDatas: [MovieInfo] = []
    
    var postDict: [String: URL] = [:]
    
    var pagerIndex: Int = 0

    var omdbData: OMDBData?
    
    var omdbDict: [String: OMDBData] = [:]

    var trailerData: TrailerData?

    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var internetLabel1: UILabel!
    @IBOutlet weak var internetLabel2: UILabel!
    
    
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
        
        let soonInfoNibs = UINib(nibName: "SoonInfoTableViewCell", bundle: nil)
        soonInfoTableView.register(soonInfoNibs, forCellReuseIdentifier: "SoonInfoCell")
        
        soonVideoView.delegate = self
        
        soonTrailerManager.delegate = self
        
        soonManager.delegate = self
        
        refref = Database.database().reference()
        
        refref.child("Soon").observeSingleEvent(of: .value) { (snapshot) in
            
            guard let value = snapshot.value else { return }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value) else { return }
            
            do {
                let soonData = try self.decoder.decode([MovieInfo].self, from: jsonData)
                print(soonData)
                
                self.soonDatas = soonData
                
                self.getPoster()
                
            } catch {
                print(error)
            }
            self.downloadData()

            self.animationView.isHidden = true

        }
    }
    
    func playTrailer() {
        let trailerKey = trailerData?.results[0].key
        
        soonVideoView.isHidden = false
        soonVideoView.loadVideoID(trailerKey ?? "QbOG7_vWFJE")
        

        
    }
    
    func getPoster() {
        
        for soonData in soonDatas {
            
            soonManager.requestOMDBData(imdbId: soonData.id ?? "tt3896198")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let index = self.typeIndex
        self.typeIndex = index // Manually trigger didSet
    }
    
    func setNavigationBarItem() {
        
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
        menuButton.addTarget(self, action: #selector(SoonViewController.menu), for: .touchUpInside)
        
//        let searchButton = UIButton()
//        searchButton.setImage(#imageLiteral(resourceName: "search-2.png"), for: .normal)
//        searchButton.imageView?.contentMode = .scaleAspectFit
//        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
//        let reightButton = UIBarButtonItem(customView: searchButton)
//        navigationItem.rightBarButtonItem = reightButton
//        reightButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        reightButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return soonDatas.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        
        guard let imdbId = soonDatas[index].id else {
            return cell
        }
        
        cell.imageView?.kf.setImage(with: postDict[imdbId])
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        soonPagerView.deselectItem(at: index, animated: true)
        soonPagerView .scrollToItem(at: index, animated: true)
        
        pagerIndex = index
        
        soonInfoTableView.reloadData()
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
        print("pagerViewWillEndDragging")
        
        print(pagerView.currentIndex)
        
        let index = pagerView.currentIndex
        
        pagerIndex = index
        
        soonInfoTableView.reloadData()
    }

    
    @objc func menu() {
        self.openSideMenu()
    }
}

extension SoonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let soonInfoCell = soonInfoTableView.dequeueReusableCell(
            withIdentifier: "SoonInfoCell",
            for: indexPath as IndexPath)
            as? SoonInfoTableViewCell else {
                return UITableViewCell()
        }
        
        soonInfoCell.trailerButton.addTarget(self, action: #selector(playTrailer(sender:)), for: .touchUpInside)
        
        guard soonDatas.count > 0 else { return soonInfoCell }
        
        // firebase data
        
        soonInfoCell.titleLabel.text = soonDatas[pagerIndex].title
        soonInfoCell.ratedLabel.text = soonDatas[pagerIndex].rated
        soonInfoCell.releaseDate.text = soonDatas[pagerIndex].releaseDate
        
        let imdbId = soonDatas[pagerIndex].id
        
        // omdb data
        
        soonInfoCell.enTitleLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Title
        soonInfoCell.duration.text = omdbDict[imdbId ?? "tt3896198"]?.Runtime
        soonInfoCell.genreLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Genre
        soonInfoCell.imdbRating.text = omdbDict[imdbId ?? "tt3896198"]?.imdbRating
        soonInfoCell.directorLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Director
        soonInfoCell.actorLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Actors
        soonInfoCell.plotLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Plot

        
        return soonInfoCell
    }
    
    @objc func playTrailer(sender: UIButton) {
        
        coverView.isHidden = false

        
        guard let cell = sender.superview?.superview as? SoonInfoTableViewCell else {
            return
            
        }
        
        guard let indexPath = soonInfoTableView.indexPath(for: cell) else { return }
        
        if soonVideoView.isHidden == true {
            
            let imdbId = soonDatas[pagerIndex].id
            
            soonTrailerManager.requestTrailerData(imdbId: imdbId ?? "tt3896198")
        }
        
        sender.isSelected = !sender.isSelected
        
        sender.setTitleColor(UIColor.white, for: .selected)
        
        if soonVideoView.ready && soonVideoView.isHidden == false {
            soonVideoView.pause()
            soonVideoView.isHidden = true
            soonPagerView.isHidden = false
            coverView.isHidden = true


        }
    }
}


extension SoonViewController: SoonManagerDelegate {
    func manager(_ manager: SoonManager, didGet products: OMDBData) {
        
        omdbData = products
        
        let posterUrl = URL(string: omdbData?.Poster ?? "https://m.media-amazon.com/images/M/MV5BMTg2MzI1MTg3OF5BMl5BanBnXkFtZTgwNTU3NDA2MTI@._V1_SX300.jpg")
        
        postDict[omdbData?.imdbID ?? "tt3896198"] = posterUrl
        omdbDict[omdbData?.imdbID ?? "tt3896198"] = omdbData
        
        self.soonPagerView.reloadData()
        self.soonInfoTableView.reloadData()
    }
    
    func manager(_ manager: SoonManager, didFailWith error: Error) {
        print(error)
    }
    
}

extension SoonViewController: SoonTrailerManagerDelegate {
    func manager(_ manager: SoonTrailerManager, didGet products: TrailerData) {
        
        trailerData = products
        
        playTrailer()
    }
    
    func manager(_ manager: SoonTrailerManager, didFailWith error: Error) {
        print(error)
    }
    
    
}
