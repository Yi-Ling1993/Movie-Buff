//
//  DateCollectionViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/25.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        dateButton.clipsToBounds = true
        dateButton.layer.cornerRadius = 4
        
    }

}
