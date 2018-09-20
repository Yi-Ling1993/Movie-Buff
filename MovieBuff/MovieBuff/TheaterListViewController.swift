//
//  TheaterListViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/20.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit

class TheaterListViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
    
    let location: [String] = ["全部", "台北東區", "台北西區", "台北北區", "台北南區"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let locationNibs = UINib(nibName: "LocationCollectionViewCell", bundle: nil)
        locationCollectionView.register(locationNibs, forCellWithReuseIdentifier: "LocationCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        locationCollectionView.collectionViewLayout = layout
        
//        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        locationCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension TheaterListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return location.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let locationCell = locationCollectionView.dequeueReusableCell(
            withReuseIdentifier: "LocationCell",
            for: indexPath as IndexPath)
            as? LocationCollectionViewCell else {
                return UICollectionViewCell()
        }
        
        locationCell.locationButton.setTitle(location[indexPath.row], for: .normal)
        
        return locationCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: locationCollectionView.frame.height)
    }
}
