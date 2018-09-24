//
//  TheaterDetailViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/24.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class TheaterDetailViewController: UIViewController {
    
    @IBOutlet weak var showTimeTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 80
    }
}
