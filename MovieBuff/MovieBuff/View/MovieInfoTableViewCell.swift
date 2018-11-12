//
//  MovieInfoTableViewCell.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/19.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var enTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var imdbRatingLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var showtimeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateMovieInfoCell(info: MovieInfo) {
        
        titleLabel.text = info.title
        ratedLabel.text = info.rated
        releaseDateLabel.text = info.releaseDate
    }
    
    func updateOMDBInfoCell(info: OMDBData) {
        
        enTitleLabel.text = info.Title
        durationLabel.text = info.Runtime
        genreLabel.text = info.Genre
        imdbRatingLabel.text = info.imdbRating
        directorLabel.text = info.Director
        actorLabel.text = info.Actors
        plotLabel.text = info.Plot
    }
    
}
