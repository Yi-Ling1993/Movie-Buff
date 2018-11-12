//
//  SoonInfoTableViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/28.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class SoonInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enTitleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateMovieInfoCell(info: MovieInfo) {
        
        titleLabel.text = info.title
        ratedLabel.text = info.rated
        releaseDate.text = info.releaseDate
    }
    
    func updateOMDBInfoCell(info: OMDBData) {
        
        enTitleLabel.text = info.Title
        duration.text = info.Runtime
        genreLabel.text = info.Genre
        imdbRating.text = info.imdbRating
        directorLabel.text = info.Director
        actorLabel.text = info.Actors
        plotLabel.text = info.Plot
    }
    
}
