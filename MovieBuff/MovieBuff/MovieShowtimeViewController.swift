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
    
    let location: [String] = ["全部地區", "台北東區", "台北西區", "台北北區", "台北南區"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "瘋狂亞洲富豪"
        
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
            
            return locationCell
            
        } else if collectionView == dateCollectionView {
            return dateCell
        }
        
        return UICollectionViewCell()
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cinemaShowtimeCell = cinemaShowtimeTableView.dequeueReusableCell(
            withIdentifier: "CinemaShowtimeCell",
            for: indexPath as IndexPath)
            as? CinemaShowtimeTableViewCell else {
                return UITableViewCell()
        }
        
        return cinemaShowtimeCell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }
}
