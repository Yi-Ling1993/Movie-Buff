//
//  CollectionViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/25.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import FSPagerView

class CollectionViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
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
            self.collectionPagerView.transformer = FSPagerViewTransformer(type:type)
            switch type {
            case .crossFading, .zoomOut, .depth:
                self.collectionPagerView.itemSize = .zero // 'Zero' means fill the size of parent
            case .linear, .overlap:
                let transform = CGAffineTransform(scaleX: 0.6, y: 0.75)
                self.collectionPagerView.itemSize = self.collectionPagerView.frame.size.applying(transform)
            case .ferrisWheel, .invertedFerrisWheel:
                self.collectionPagerView.itemSize = CGSize(width: 180, height: 140)
            case .coverFlow:
                self.collectionPagerView.itemSize = CGSize(width: 220, height: 170)
            case .cubic:
                let transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                self.collectionPagerView.itemSize = self.collectionPagerView.frame.size.applying(transform)
            }
        }
    }
    
    @IBOutlet weak var collectionPagerView: FSPagerView! {
        didSet {
            self.collectionPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.typeIndex = 4
        }
    }
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var seenTableView: UITableView!
    
    @IBOutlet weak var collectedTableView: UITableView!
    
    @IBOutlet weak var posterView: UIView!
    
    @IBAction func indexChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            collectedTableView.isHidden = false
            posterView.isHidden = false
            seenTableView.isHidden = true
        case 1:
            collectedTableView.isHidden = true
            posterView.isHidden = true
            seenTableView.isHidden = false

        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()
        
        segmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white ], for: .normal)
        
        segmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white ], for: .selected)
        
        let collectedNibs = UINib(nibName: "CollectedTableViewCell", bundle: nil)
        collectedTableView.register(collectedNibs, forCellReuseIdentifier: "CollectedCell")
        
        let seenNibs = UINib(nibName: "SeenTableViewCell", bundle: nil)
        seenTableView.register(seenNibs, forCellReuseIdentifier: "SeenCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let index = self.typeIndex
        self.typeIndex = index // Manually trigger didSet
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
        collectionPagerView.deselectItem(at: index, animated: true)
        collectionPagerView .scrollToItem(at: index, animated: true)
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
        menuButton.addTarget(self, action: #selector(CollectionViewController.menu), for: .touchUpInside)

        
        let searchButton = UIButton()
        searchButton.setImage(#imageLiteral(resourceName: "search-2.png"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let reightButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = reightButton
        reightButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        reightButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    @objc func menu() {
        self.openSideMenu()
    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == collectedTableView {
            return 1
        } else if tableView == seenTableView {
            return 5
        }
        
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let collectedCell = collectedTableView.dequeueReusableCell(
            withIdentifier: "CollectedCell",
            for: indexPath as IndexPath)
            as? CollectedTableViewCell else {
                return UITableViewCell()
        }
        
        collectedCell.collectionShowtimeButton.addTarget(self, action: #selector(toShowtime), for: .touchUpInside)
        
        guard let seenCell = seenTableView.dequeueReusableCell(
            withIdentifier: "SeenCell",
            for: indexPath as IndexPath)
            as? SeenTableViewCell else {
                return UITableViewCell()
        }
        
        if tableView == collectedTableView {
            return collectedCell
        } else if tableView == seenTableView {
            return seenCell
        }
        
        return UITableViewCell()
    }
    
    @objc func toShowtime(sender: UIButton) {
        performSegue(withIdentifier: "CollectionToShowtime", sender: self)
    }
}
