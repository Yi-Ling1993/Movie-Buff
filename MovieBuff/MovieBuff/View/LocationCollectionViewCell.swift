//
//  LocationCollectionViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/20.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var locationButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        locationButton.clipsToBounds = true
        locationButton.layer.cornerRadius = 4
    }

}
