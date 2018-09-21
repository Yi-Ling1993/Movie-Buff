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
    @IBOutlet weak var theaterTableView: UITableView!
    
    let data = Data()
    
//    var theaterInfo: [TheaterInfo] = [
//        TheaterInfo(name: "台北信義威秀", address: "台北市信義區松壽路16,18號", region: "台北東區"),
//        TheaterInfo(name: "國賓微風影城", address: "台北市松山區復興南路一段39號(微風廣場7樓)", region: "台北東區"),
//        TheaterInfo(name: "誠品電影院", address: "台北市信義區菸廠路88號B2", region: "台北東區")
//    ]
    
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

extension TheaterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Data.instance.theaterInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let theaterCell = theaterTableView.dequeueReusableCell(
            withIdentifier: "TheaterCell",
            for: indexPath as IndexPath)
            as? TheaterTableViewCell else {
                return UITableViewCell()
        }
        
        theaterCell.theaterName.text = Data.instance.theaterInfo[indexPath.row].name
        theaterCell.addressLabel.text = Data.instance.theaterInfo[indexPath.row].address
        
        return theaterCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
