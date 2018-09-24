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
    
    let location: [String] = ["全部地區", "台北東區", "台北西區", "台北北區", "台北南區"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let locationNibs = UINib(nibName: "LocationCollectionViewCell", bundle: nil)
        regionCollectionView.register(locationNibs, forCellWithReuseIdentifier: "LocationCell")
        
        let dateNibs = UINib(nibName: "DateCollectionViewCell", bundle: nil)
        dateCollectionView.register(dateNibs, forCellWithReuseIdentifier: "DateCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        regionCollectionView.collectionViewLayout = layout
        dateCollectionView.collectionViewLayout = layout

        
        regionCollectionView.showsHorizontalScrollIndicator = false
        dateCollectionView.showsHorizontalScrollIndicator = false

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
}

extension MovieShowtimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return location.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let locationCell = regionCollectionView.dequeueReusableCell(
            withReuseIdentifier: "LocationCell",
            for: indexPath as IndexPath)
            as? LocationCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        locationCell.locationButton.setTitle(location[indexPath.row], for: .normal)
        
        
        return locationCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: regionCollectionView.frame.height)
    }
}
