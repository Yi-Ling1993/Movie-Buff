//
//  ShowtimeTableViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/24.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class ShowtimeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var showtimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backGroundView.backgroundColor = UIColor(red: 77/255, green: 75/255, blue: 75/255, alpha: 1)
        backGroundView.layer.cornerRadius = 2
        backGroundView.layer.masksToBounds = false
        
        backGroundView.layer.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backGroundView.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
