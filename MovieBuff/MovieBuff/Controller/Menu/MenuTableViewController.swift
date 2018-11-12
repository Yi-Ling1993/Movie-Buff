//
//  MenuTableViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/27.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let items = MenuItems()
    
    var selectedIndex: Int = 0
    
    var viewControllerIdentifier: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.bounces = false
        
        self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 30, right: 0)
        
        self.tableView.register(MenuTableViewCell.self,
                                forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0),
                                 animated: false,
                                 scrollPosition: UITableView.ScrollPosition.top)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell",
                                                       for: indexPath as IndexPath) as? MenuTableViewCell else {
                                                        return UITableViewCell()
        }
        
        cell.iconView.image = self.items.getIcon((indexPath as NSIndexPath).row)
        cell.titleLabel.text = self.items.getTitle((indexPath as NSIndexPath).row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if indexPath.row == 0 {
            viewControllerIdentifier = "InTheater"
        } else if indexPath.row == 1 {
            viewControllerIdentifier = "ThisWeek"
        } else if indexPath.row == 2 {
            viewControllerIdentifier = "Soon"
        } else if indexPath.row == 3 {
            viewControllerIdentifier = "TheaterList"
        } else if indexPath.row == 4 {
            viewControllerIdentifier = "Collection"
        }
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
//        let rootNC = UINavigationController(rootViewController: rootVC)
        self.changeViewController(rootVC)
        
        selectedIndex = indexPath.row
    }
    
}
