//
//  MovieShowtimeViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/25.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class MovieShowtimeViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var regionCollectionView: UICollectionView!
    
    @IBOutlet weak var dateCollectionView: UICollectionView!
    
    @IBOutlet weak var cinemaShowtimeTableView: UITableView!
    
    var firebaseMovieData: MovieInfo?
    
    var filteredFirebaseData: [MovieTheaterInfo] = []
    
    let location: [String] = ["全部地區", "台北東區", "台北西區", "台北北區", "台北南區"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredFirebaseData = firebaseMovieData?.theater ?? []
        
        title = firebaseMovieData?.title
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        let locationNibs = UINib(nibName: "LocationCollectionViewCell", bundle: nil)
        regionCollectionView.register(locationNibs, forCellWithReuseIdentifier: "LocationCell")
        
        let dateNibs = UINib(nibName: "DateCollectionViewCell", bundle: nil)
        dateCollectionView.register(dateNibs, forCellWithReuseIdentifier: "DateCell")
        
        // 一個 layout 不要給兩個用，上面那個會爆掉
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        regionCollectionView.collectionViewLayout = layout
        regionCollectionView.showsHorizontalScrollIndicator = false

        let dateLayout = UICollectionViewFlowLayout()
        dateLayout.scrollDirection = .horizontal
        dateCollectionView.collectionViewLayout = dateLayout
        dateCollectionView.showsHorizontalScrollIndicator = false

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        if collectionView == regionCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        } else if collectionView == dateCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)

        }
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

extension MovieShowtimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == regionCollectionView {
            
            return location.count

        } else if collectionView == dateCollectionView {
            
            return 7
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let locationCell = regionCollectionView.dequeueReusableCell(
            withReuseIdentifier: "LocationCell",
            for: indexPath as IndexPath)
            as? LocationCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        guard let dateCell = dateCollectionView.dequeueReusableCell(
            withReuseIdentifier: "DateCell",
            for: indexPath as IndexPath)
            as? DateCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        if collectionView == regionCollectionView {
            
            locationCell.locationButton.setTitle(location[indexPath.row], for: .normal)
            
            locationCell.locationButton.addTarget(self, action: #selector(filterLocation(sender:)), for: .touchUpInside)
            
            return locationCell
            
        } else if collectionView == dateCollectionView {
            return dateCell
        }
        
        return UICollectionViewCell()
    }
    
    @objc func filterLocation(sender: UIButton) {
        print(sender.tag)
        
        if sender.titleLabel?.text != "全部地區" {
            
            filteredFirebaseData = firebaseMovieData?.theater?.filter{$0.region == sender.titleLabel?.text} ?? []
            
            cinemaShowtimeTableView.reloadData()
        } else {
            
            filteredFirebaseData = firebaseMovieData?.theater ?? []
            
            cinemaShowtimeTableView.reloadData()
        }
        
        print(filteredFirebaseData)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == regionCollectionView {
            
            return CGSize(width: 100, height: regionCollectionView.frame.height)
        } else if collectionView == dateCollectionView {
            
            return CGSize(width: 70, height: dateCollectionView.frame.height)
        }
        
        return CGSize(width: 0, height: 0)
    }
}

extension MovieShowtimeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredFirebaseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cinemaShowtimeCell = cinemaShowtimeTableView.dequeueReusableCell(
            withIdentifier: "CinemaShowtimeCell",
            for: indexPath as IndexPath)
            as? CinemaShowtimeTableViewCell else {
                return UITableViewCell()
        }
        
        cinemaShowtimeCell.theaterNameLabel.text = filteredFirebaseData[indexPath.row].name
        cinemaShowtimeCell.presentLabel.text = filteredFirebaseData[indexPath.row].present
        cinemaShowtimeCell.languageLabel.text = filteredFirebaseData[indexPath.row].language
        
        var showtimeString = ""
        let showtimeCount: Int = (filteredFirebaseData[indexPath.row].showtime?[0].time?.count)! - 1
        for index in 0 ... showtimeCount {
            
            showtimeString += "\(filteredFirebaseData[indexPath.row].showtime![0].time![index])   "
        }
        
        let attriString = NSMutableAttributedString(string: showtimeString)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 15
        style.minimumLineHeight = 0
        attriString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: showtimeString.characters.count))

        
        cinemaShowtimeCell.shoetimeLabel.attributedText = attriString
        
        return cinemaShowtimeCell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
}


