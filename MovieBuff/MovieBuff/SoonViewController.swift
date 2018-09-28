//
//  SoonViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/28.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class SoonViewController: UIViewController {

    @IBOutlet weak var soonInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarItem()
        
        let soonInfoNibs = UINib(nibName: "SoonInfoTableViewCell", bundle: nil)
        soonInfoTableView.register(soonInfoNibs, forCellReuseIdentifier: "SoonInfoCell")
    }
    
    func setNavigationBarItem() {
        
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
