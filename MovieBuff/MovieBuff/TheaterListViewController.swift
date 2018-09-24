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
    
    var filteredRegion: [TheaterInfo] = TheaterData.instance.theaterInfo
    
    let data = TheaterData()
    
    let location: [String] = ["全部", "台北東區", "台北西區", "台北北區", "台北南區"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let locationNibs = UINib(nibName: "LocationCollectionViewCell", bundle: nil)
        locationCollectionView.register(locationNibs, forCellWithReuseIdentifier: "LocationCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        locationCollectionView.collectionViewLayout = layout
        
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

        locationCell.locationButton.tag = indexPath.row
        locationCell.locationButton.addTarget(self, action: #selector(filterLocation(sender:)), for: .touchUpInside)

        
        return locationCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: locationCollectionView.frame.height)
    }
}

extension TheaterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredRegion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let theaterCell = theaterTableView.dequeueReusableCell(
            withIdentifier: "TheaterCell",
            for: indexPath as IndexPath)
            as? TheaterTableViewCell else {
                return UITableViewCell()
        }
        
        theaterCell.theaterName.text = filteredRegion[indexPath.row].name
        theaterCell.addressLabel.text = filteredRegion[indexPath.row].address
    
        return theaterCell
    }
    
    @objc func filterLocation(sender: UIButton) {
        print(sender.tag)
        
        
        sender.layer.borderColor = UIColor(red: 149/255, green: 208/255, blue: 120/255, alpha: 1).cgColor
        sender.layer.borderWidth = 2
        
    
        
        

        if sender.titleLabel?.text != "全部" {
            
            filteredRegion = TheaterData.instance.theaterInfo.filter{$0.region == sender.titleLabel?.text}
            
            theaterTableView.reloadData()
        } else {
            
            filteredRegion = TheaterData.instance.theaterInfo
            
            theaterTableView.reloadData()
        }
        
        print(filteredRegion)
        

        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
