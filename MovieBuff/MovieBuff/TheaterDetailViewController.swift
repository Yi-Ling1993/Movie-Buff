//
//  TheaterDetailViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/24.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import FSPagerView

class TheaterDetailViewController: UIViewController, FSPagerViewDelegate, FSPagerViewDataSource {
    
    @IBAction func toWebview(_ sender: Any) {
        performSegue(withIdentifier: "ToWebview", sender: self)
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
            self.theaterDetailPagerView.transformer = FSPagerViewTransformer(type:type)
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = "誠品電影院"
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
        theaterDetailPagerView.deselectItem(at: index, animated: true)
        theaterDetailPagerView .scrollToItem(at: index, animated: true)
    }
    
}

extension TheaterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let showtimeCell = showTimeTableView.dequeueReusableCell(
            withIdentifier: "ShowtimeCell",
            for: indexPath as IndexPath)
            as? ShowtimeTableViewCell else {
                return UITableViewCell()
        }
                
        return showtimeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
