//
//  TheaterListViewController.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/20.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import UIKit
import WKAwesomeMenu

class TheaterListViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var theaterTableView: UITableView!
    
    var filteredRegion: [TheaterInfo] = TheaterData.instance.theaterInfo
    
    let data = TheaterData()
    
    let location: [String] = ["全部地區", "台北東區", "台北西區", "台北北區", "台北南區"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()        
      
        let locationNibs = UINib(nibName: "LocationCollectionViewCell", bundle: nil)
        
        locationCollectionView.register(locationNibs, forCellWithReuseIdentifier: "LocationCell")
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        locationCollectionView.collectionViewLayout = layout
        
        locationCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func setNavigationBarItem() {
        
        let menuButton = UIButton()
        menuButton.setImage(#imageLiteral(resourceName: "listing-option.png"), for: .normal)
        menuButton.imageView?.contentMode = .scaleAspectFit
        menuButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let leftButton = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = leftButton
        leftButton.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        leftButton.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
        menuButton.addTarget(self, action: #selector(TheaterListViewController.menu), for: .touchUpInside)
        
        let searchButton = UIButton()
        searchButton.setImage(#imageLiteral(resourceName: "search-2.png"), for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit
        searchButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let reightButton = UIBarButtonItem(customView: searchButton)
        navigationItem.rightBarButtonItem = reightButton
        reightButton.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        reightButton.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    @objc func menu() {
        self.openSideMenu()
        
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
        theaterCell.navigationButton.tag = indexPath.row
        theaterCell.pinButton.tag = indexPath.row
        theaterCell.navigationButton.addTarget(self, action: #selector(navigate(sender:)), for: .touchUpInside)
        theaterCell.pinButton.addTarget(self, action: #selector(pin(sender:)), for: .touchUpInside)
        
        if filteredRegion[indexPath.row].isPinned == true {
            theaterCell.pinButton.isSelected = true
            
        } else {
            theaterCell.pinButton.isSelected = false
        }
        
    
        return theaterCell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc func filterLocation(sender: UIButton) {
        print(sender.tag)
    
        sender.layer.borderColor = UIColor(red: 149/255, green: 208/255, blue: 120/255, alpha: 1).cgColor
        sender.layer.borderWidth = 2
        
        if sender.titleLabel?.text != "全部地區" {
            
            filteredRegion = TheaterData.instance.theaterInfo.filter{$0.region == sender.titleLabel?.text}
            
            theaterTableView.reloadData()
        } else {
            
            filteredRegion = TheaterData.instance.theaterInfo
            
            theaterTableView.reloadData()
        }
        
        print(filteredRegion)
        

        }
    
    @objc func navigate(sender: UIButton) {
        print(sender.tag)
        
        let lati = filteredRegion[sender.tag].latitude
        let longti = filteredRegion[sender.tag].long
        
        let googleMapAppDeepLink = URL(string: "comgooglemaps://?saddr=&daddr=\(lati),\(longti)&directionsmode=driving")
        
        if UIApplication.shared.canOpenURL(googleMapAppDeepLink!) {
            UIApplication.shared.open(googleMapAppDeepLink!, options: [:], completionHandler: nil)
        } else {
            // 若手機沒安裝 Google Map App 則導到 App Store(id443904275 為 Google Map App 的 ID)
            let appStoreGoogleMapURL = URL(string: "itms-apps://itunes.apple.com/app/id585027354")!
            UIApplication.shared.open(appStoreGoogleMapURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func pin(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        filteredRegion[sender.tag].isPinned = sender.isSelected
        
        print(filteredRegion[sender.tag])
        
        for index in 0 ..< TheaterData.instance.theaterInfo.count {
            
            if filteredRegion[sender.tag].name == TheaterData.instance.theaterInfo[index].name {
                
                TheaterData.instance.theaterInfo[index].isPinned = filteredRegion[sender.tag].isPinned
            }
        }
        
        if sender.isSelected == true {
            
            guard let cell = sender.superview?.superview as? TheaterTableViewCell else { return }
            
            guard let indexPath = theaterTableView.indexPath(for: cell) else { return }
            
            print(indexPath)
            
            theaterTableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            
            TheaterData.instance.theaterInfo.remove(at: indexPath.row)
            TheaterData.instance.theaterInfo.insert(filteredRegion[sender.tag], at: 0)
            
        }
        
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
