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
    
    @IBOutlet weak var collectedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white ], for: .normal)
        
        segmentControl.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white ], for: .selected)
        
        let collectedNibs = UINib(nibName: "CollectedTableViewCell", bundle: nil)
        collectedTableView.register(collectedNibs, forCellReuseIdentifier: "CollectedCell")
    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let collectedCell = collectedTableView.dequeueReusableCell(
            withIdentifier: "CollectedCell",
            for: indexPath as IndexPath)
            as? CollectedTableViewCell else {
                return UITableViewCell()
        }
        
        return collectedCell
    }
}
