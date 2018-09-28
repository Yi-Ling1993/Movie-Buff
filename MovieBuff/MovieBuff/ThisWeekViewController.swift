//
//  ThisWeekViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/28.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class ThisWeekViewController: UIViewController {
    
    @IBOutlet weak var thisWeekInfoTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarItem()
        
        let thisWeekInfoNibs = UINib(nibName: "ThisWeekInfoTableViewCell", bundle: nil)
        thisWeekInfoTableView.register(thisWeekInfoNibs, forCellReuseIdentifier: "ThisWeekInfoCell")
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
        
        return thisWeekInfoCell
    }
}

