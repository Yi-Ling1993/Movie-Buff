//
//  SoonViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/28.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import FSPagerView

class SoonViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
    @IBAction func soonToShowtime(_ sender: Any) {
        self.performSegue(withIdentifier: "SoonToShowtime", sender: self)
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarItem()
        
        let soonInfoNibs = UINib(nibName: "SoonInfoTableViewCell", bundle: nil)
        soonInfoTableView.register(soonInfoNibs, forCellReuseIdentifier: "SoonInfoCell")
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
        soonPagerView.deselectItem(at: index, animated: true)
        soonPagerView .scrollToItem(at: index, animated: true)
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
        
        return soonInfoCell
    }
}