//
//  SeenTableViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/25.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class SeenTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seenBackgroundView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()

        seenBackgroundView.backgroundColor = UIColor(red: 77/255, green: 75/255, blue: 75/255, alpha: 1)
        seenBackgroundView.layer.cornerRadius = 2
        seenBackgroundView.layer.masksToBounds = false
        
        seenBackgroundView.layer.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        seenBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        seenBackgroundView.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
