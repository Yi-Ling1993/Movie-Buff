//
//  TheaterTableViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/20.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class TheaterTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundCardView: UIView!
    @IBOutlet weak var theaterName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var pinButton: UIButton!
    @IBOutlet weak var navigationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundCardView.backgroundColor = UIColor(red: 77/255, green: 75/255, blue: 75/255, alpha: 1)
        backGroundCardView.layer.cornerRadius = 2
        backGroundCardView.layer.masksToBounds = false
        
        backGroundCardView.layer.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        backGroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backGroundCardView.layer.shadowOpacity = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateTheaterCell(info: TheaterInfo) {
        theaterName.text = info.name
        addressLabel.text = info.address
    }

}
