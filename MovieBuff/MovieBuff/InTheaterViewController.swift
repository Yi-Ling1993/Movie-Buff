//
//  ViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/19.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import WKAwesomeMenu
import FSPagerView
import YouTubePlayer_Swift
import FirebaseDatabase
import Firebase

class InTheaterViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        
        videoView.alpha = 1
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    
    
    @IBOutlet weak var videoView: YouTubePlayerView!
    
    @IBAction func inTheaterToShowtime(_ sender: Any) {
        
        self.performSegue(withIdentifier: "InTheaterToShowtime", sender: self)
    }
    
//    @IBAction func unwind (for segue: UIStoryboardSegue) {
//    print("back...")
//    }
    
    
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
            self.inTheaterPagerView.transformer = FSPagerViewTransformer(type:type)
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
    
    @IBOutlet weak var inTheaterPagerView: FSPagerView! {
        didSet {
            self.inTheaterPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
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
    
//    var trailerKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()
        
        let infoNibs = UINib(nibName: "MovieInfoTableViewCell", bundle: nil)
        infoTableView.register(infoNibs, forCellReuseIdentifier: "InfoCell")
        
        videoView.delegate = self
        
        
        inTheaterTrailerManager.delegate = self
        
        inTheaterManager.delegate = self
        
        inTheaterManager.requestOMDBData()
        
        
        refref = Database.database().reference()
        
        refref.child("InTheater").observeSingleEvent(of: .value) { (snapshot) in
//            print(snapshot)
            
            guard let value = snapshot.value else { return }
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value) else { return }
            
            do {
                let inTheaterData = try self.decoder.decode([MovieInfo].self, from: jsonData)
                print(inTheaterData)
                
                self.inTheaterDatas = inTheaterData
                
                self.infoTableView.reloadData()
            } catch {
                print(error)
            }
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
        
        let searchButton = UIButton()
        searchButton.setImage(#imageLiteral(resourceName: "search-2.png"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let reightButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = reightButton
        reightButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        reightButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        

    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
//        cell.contentView.layer.shadowColor = UIColor.white.withAlphaComponent(1).cgColor
        
        
        
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        inTheaterPagerView.deselectItem(at: index, animated: true)
        inTheaterPagerView .scrollToItem(at: index, animated: true)
    }

    
}

extension InTheaterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inTheaterDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let infoCell = infoTableView.dequeueReusableCell(
            withIdentifier: "InfoCell",
            for: indexPath as IndexPath)
            as? MovieInfoTableViewCell else {
                return UITableViewCell()
        }
        
        infoCell.trailerButton.addTarget(self, action: #selector(playTrailer(sender:)), for: .touchUpInside)
        
        infoCell.titleLabel.text = inTheaterDatas[indexPath.row].title
        infoCell.ratedLabel.text = inTheaterDatas[indexPath.row].rated
        infoCell.releaseDateLabel.text = inTheaterDatas[indexPath.row].releaseDate
        
        
        

        
        return infoCell
    }
    
    @objc func playTrailer(sender: UIButton) {
        
        guard let cell = sender.superview?.superview as? MovieInfoTableViewCell else { return }
        
        guard let indexPath = infoTableView.indexPath(for: cell) else { return }
        
        
        let imdbId = inTheaterDatas[indexPath.row].id
        
        inTheaterTrailerManager.requestTrailerData(imdbId: imdbId)
        
        sender.isSelected = !sender.isSelected
        
        let trailerKey = trailerData?.results[0].key
        
        sender.setTitleColor(UIColor.white, for: .selected)
        
        if videoView.ready && videoView.isHidden == false{
            videoView.pause()
            videoView.isHidden = true
            
        } else {
            
            videoView.isHidden = false
            videoView.loadVideoID(trailerKey ?? "QbOG7_vWFJE")
        }

        
        
        
    }
}

extension InTheaterViewController: InTheaterManagerDelegate {
    func manager(_ manager: InTheaterManager, didGet products: OMDBData) {
        omdbData = products
    }
    
    func manager(_ manager: InTheaterManager, didFailWith error: Error) {
        print(error)
    }
    
    
}

extension InTheaterViewController: InTheaterTrailerManagerDelegate {
    func manager(_ manager: InTheaterTrailerManager, didGet products: TrailerData) {
        trailerData = products
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
            }
            else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
}

