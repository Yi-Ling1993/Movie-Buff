//
//  CinemaShowtimeTableViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/25.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class CinemaShowtimeTableViewCell: UITableViewCell {

    @IBOutlet weak var cinemaBackgroundView: UIView!
    
    @IBOutlet weak var theaterNameLabel: UILabel!
    @IBOutlet weak var presentLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var shoetimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cinemaBackgroundView.backgroundColor = UIColor(red: 77/255, green: 75/255, blue: 75/255, alpha: 1)
        cinemaBackgroundView.layer.cornerRadius = 2
        cinemaBackgroundView.layer.masksToBounds = false
        
        cinemaBackgroundView.layer.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        cinemaBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cinemaBackgroundView.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
