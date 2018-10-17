//
//  ThisWeekViewController.swift
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

class ThisWeekViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource, YouTubePlayerDelegate {
    
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
            
        } else {
            
            internetLabel1.isHidden = true
            internetLabel2.isHidden = true
            
        }
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        thisWeekVideoView.alpha = 1
        thisWeekPagerView.isHidden = true
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
            self.thisWeekPagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.thisWeekPagerView.itemSize = .zero // 'Zero' means fill the size of parent
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.thisWeekPagerView.itemSize = self.thisWeekPagerView.frame.size.applying(transform)
            case .ferrisWheel, .invertedFerrisWheel:
                self.thisWeekPagerView.itemSize = CGSize(width: 180, height: 140)
            case .coverFlow:
                self.thisWeekPagerView.itemSize = CGSize(width: 220, height: 170)
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.thisWeekPagerView.itemSize = self.thisWeekPagerView.frame.size.applying(transform)
            }
        }
    }
    
    @IBOutlet weak var thisWeekInfoTableView: UITableView!
    
    @IBOutlet weak var thisWeekPagerView: FSPagerView! {
        didSet {
            self.thisWeekPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
            
            thisWeekPagerView.isInfinite = true

        }
    }
    
    @IBOutlet weak var thisWeekVideoView: YouTubePlayerView!
    
    var thisWeekDatas: [MovieInfo] = []
    
    var pagerIndex: Int = 0
    
    var thisWeekTrailerManager = ThisWeekTrailerManager()
    
    var thisWeekManager = ThisWeekManager()
    
    let decoder = JSONDecoder()
    
    var refref: DatabaseReference!
    
    var omdbData: OMDBData?
    
    var postDict: [String: URL] = [:]
    
    var omdbDict: [String: OMDBData] = [:]
    
    var trailerData: TrailerData?
    
    @IBOutlet weak var animationView: UIView!
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
        
        let thisWeekInfoNibs = UINib(nibName: "ThisWeekInfoTableViewCell", bundle: nil)
        thisWeekInfoTableView.register(thisWeekInfoNibs, forCellReuseIdentifier: "ThisWeekInfoCell")
        
        thisWeekVideoView.delegate = self
        
        
        thisWeekTrailerManager.delegate = self
        
        thisWeekManager.delegate = self
        
        refref = Database.database().reference()
        
        refref.child("ThisWeek").observeSingleEvent(of: .value) { (snapshot) in
            //            print(snapshot)
            
            guard let value = snapshot.value else { return }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value) else { return }
            
            do {
                let thisWeekData = try self.decoder.decode([MovieInfo].self, from: jsonData)
                print(thisWeekData)
                
                self.thisWeekDatas = thisWeekData
                
                self.getPoster()
                
            } catch {
                print(error)
            }
            self.downloadData()
            
            self.animationView.isHidden = true

        }
    }
    
    func getPoster() {
        
        for thisWeekData in thisWeekDatas {
            
            thisWeekManager.requestOMDBData(imdbId: thisWeekData.id ?? "tt3896198")
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
        menuButton.addTarget(self, action: #selector(ThisWeekViewController.menu), for: .touchUpInside)
        
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
        return thisWeekDatas.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        
        guard let imdbId = thisWeekDatas[index].id else {
            return cell
        }
        
        cell.imageView?.kf.setImage(with: postDict[imdbId])
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        thisWeekPagerView.deselectItem(at: index, animated: true)
        thisWeekPagerView .scrollToItem(at: index, animated: true)
        
        pagerIndex = index
        
        thisWeekInfoTableView.reloadData()
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
        print("pagerViewWillEndDragging")
        
        print(pagerView.currentIndex)
        
        let index = pagerView.currentIndex
        
        pagerIndex = index
        
        thisWeekInfoTableView.reloadData()
    }

    
    @objc func menu() {
        self.openSideMenu()
    }
   

}

extension ThisWeekViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let thisWeekInfoCell = thisWeekInfoTableView.dequeueReusableCell(
            withIdentifier: "ThisWeekInfoCell",
            for: indexPath as IndexPath)
            as? ThisWeekInfoTableViewCell else {
                return UITableViewCell()
        }
        
        guard thisWeekDatas.count > 0 else { return thisWeekInfoCell }
        
        // firebase data
        
        thisWeekInfoCell.titleLabel.text = thisWeekDatas[pagerIndex].title
        thisWeekInfoCell.ratedLabel.text = thisWeekDatas[pagerIndex].rated
        thisWeekInfoCell.releaseLabel.text = thisWeekDatas[pagerIndex].releaseDate
        
        let imdbId = thisWeekDatas[pagerIndex].id
        
        // omdb data
        
        thisWeekInfoCell.enTitleLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Title
        thisWeekInfoCell.durationLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Runtime
        thisWeekInfoCell.genreLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Genre
        thisWeekInfoCell.imdbRatingLabel.text = omdbDict[imdbId ?? "tt3896198"]?.imdbRating
        thisWeekInfoCell.directorLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Director
        thisWeekInfoCell.actorLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Actors
        thisWeekInfoCell.plotLabel.text = omdbDict[imdbId ?? "tt3896198"]?.Plot
        
        thisWeekInfoCell.toShowtimeButton.addTarget(self, action: #selector(toShowtime(sender:)), for: .touchUpInside)
        
        thisWeekInfoCell.trailerButton.addTarget(self, action: #selector(playTrailer(sender:)), for: .touchUpInside)

        return thisWeekInfoCell
    }
    
    @objc func toShowtime(sender: UIButton) {
        self.performSegue(withIdentifier: "ThisWeekToShowtime", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showtimeController = segue.destination as? MovieShowtimeViewController else {return}
        
        showtimeController.firebaseMovieData = thisWeekDatas[pagerIndex]
        
    }
    
    @objc func playTrailer(sender: UIButton) {
        
        coverView.isHidden = false
        
        guard let cell = sender.superview?.superview as? ThisWeekInfoTableViewCell else { return }
        
        guard let indexPath = thisWeekInfoTableView.indexPath(for: cell) else { return }
        
        if thisWeekVideoView.isHidden == true {
            
            let imdbId = thisWeekDatas[pagerIndex].id
            
            thisWeekTrailerManager.requestTrailerData(imdbId: imdbId ?? "tt3896198")
        }
        
        sender.isSelected = !sender.isSelected
        
        sender.setTitleColor(UIColor.white, for: .selected)
        
        if thisWeekVideoView.ready && thisWeekVideoView.isHidden == false {
            thisWeekVideoView.pause()
            thisWeekVideoView.isHidden = true
            thisWeekPagerView.isHidden = false
            coverView.isHidden = true

        }
        
    }
    
    func playTrailer() {
        let trailerKey = trailerData?.results[0].key
        
        thisWeekVideoView.isHidden = false
        thisWeekVideoView.loadVideoID(trailerKey ?? "QbOG7_vWFJE")
        
    }
}

extension ThisWeekViewController: ThisWeekManagerDelegate {
    func manager(_ manager: ThisWeekManager, didGet products: OMDBData) {
        omdbData = products
        
        let posterUrl = URL(string: omdbData?.Poster ?? "https://m.media-amazon.com/images/M/MV5BMTg2MzI1MTg3OF5BMl5BanBnXkFtZTgwNTU3NDA2MTI@._V1_SX300.jpg")
        
        postDict[omdbData?.imdbID ?? "tt3896198"] = posterUrl
        omdbDict[omdbData?.imdbID ?? "tt3896198"] = omdbData
        
        self.thisWeekPagerView.reloadData()
        self.thisWeekInfoTableView.reloadData()
    }
    
    func manager(_ manager: ThisWeekManager, didFailWith error: Error) {
        print(error)
    }
    
}

extension ThisWeekViewController: ThisWeekTrailerManagerDelegate {
    func manager(_ manager: ThisWeekTrailerManager, didGet products: TrailerData) {
        trailerData = products
        
        playTrailer()
    }
    
    func manager(_ manager: ThisWeekTrailerManager, didFailWith error: Error) {
        print(error)
    }
    
    
}

