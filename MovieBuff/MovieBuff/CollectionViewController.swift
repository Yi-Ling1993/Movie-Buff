//
//  CollectionViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/25.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

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
        
        segmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white ], for: .normal)
        
        segmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white ], for: .selected)
        
        let collectedNibs = UINib(nibName: "CollectedTableViewCell", bundle: nil)
        collectedTableView.register(collectedNibs, forCellReuseIdentifier: "CollectedCell")
        
        let seenNibs = UINib(nibName: "SeenTableViewCell", bundle: nil)
        seenTableView.register(seenNibs, forCellReuseIdentifier: "SeenCell")
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
}
