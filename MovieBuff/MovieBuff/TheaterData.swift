//
//  TheaterData.swift
//  MovieBuff
//
//  Created by 劉奕伶 on 2018/9/21.
//  Copyright © 2018年 Appwork School. All rights reserved.
//

import Foundation

struct TheaterInfo {
    
    let name: String
    let address: String
    let region: String
    let latitude: Double
    let long: Double
    var isPinned: Bool = false
}

class TheaterData {
    
    static let instance = TheaterData()
    
    var theaterInfo: [TheaterInfo] = [
        TheaterInfo(name: "台北信義威秀", address: "台北市信義區松壽路16,18號", region: "台北東區", latitude: 25.036005, long: 121.566810, isPinned: false),
        TheaterInfo(name: "國賓微風影城", address: "台北市松山區復興南路一段39號(微風廣場7樓)", region: "台北東區", latitude: 25.046374, long: 121.544140, isPinned: false),
        TheaterInfo(name: "誠品電影院", address: "台北市信義區菸廠路88號B2", region: "台北東區", latitude: 25.044877, long: 121.561500, isPinned: false),
        TheaterInfo(name: "新民生戲院", address: "台北市松山區民生東路五段190號3樓", region: "台北東區", latitude: 25.058965, long: 121.564190, isPinned: false),
        TheaterInfo(name: "喜滿客京華影城", address: "台北市松山區八德路四段138號B1", region: "台北東區", latitude: 25.048391, long: 121.561833, isPinned: false),
        TheaterInfo(name: "喜樂時代影城", address: "台北市南港區忠孝東路7段299號11-14樓", region: "台北東區", latitude: 25.052574, long: 121.603717, isPinned: false),
        TheaterInfo(name: "梅花數位影院", address: "台北市大安區和平東路三段63號2樓", region: "台北東區", latitude: 25.025105, long: 121.549237, isPinned: false),
        TheaterInfo(name: "總督影城", address: "台北市松山區長安東路二段219號5樓之1", region: "台北東區", latitude: 25.048623, long: 121.544825, isPinned: false),
        TheaterInfo(name: "哈拉影城", address: "台北市內湖區康寧路三段72號", region: "台北東區", latitude: 25.070233, long: 121.611461, isPinned: false),
        TheaterInfo(name: "台北新光影城", address: "台北市萬華區西寧南路36號4樓,5樓", region: "台北西區", latitude: 25.045563, long: 121.506484, isPinned: false),
        TheaterInfo(name: "樂聲影城", address: "台北市萬華區武昌街二段85號", region: "台北西區", latitude: 25.045605, long: 121.504890, isPinned: false),
        TheaterInfo(name: "台北日新威秀", address: "台北市萬華區武昌街二段87號", region: "台北西區", latitude: 25.045805, long: 121.504166, isPinned: false),
        TheaterInfo(name: "台北京站威秀", address: "台北市大同區市民大道一段209號5樓", region: "台北西區", latitude: 25.049233, long: 121.518567, isPinned: false),
        TheaterInfo(name: "in89豪華數位影城", address: "台北市萬華區武昌街二段89號", region: "台北西區", latitude: 25.045687, long: 121.503961, isPinned: false),
        TheaterInfo(name: "真善美戲院", address: "台北市萬華區漢中街116號", region: "台北西區", latitude: 25.042958, long: 121.507498, isPinned: false),
        TheaterInfo(name: "國賓戲院", address: "台北市萬華區成都路88號", region: "台北西區", latitude: 25.043115, long: 121.504561, isPinned: false),
        TheaterInfo(name: "今日秀泰影城", address: "台北市萬華區峨眉街52號", region: "台北西區", latitude: 25.043885, long: 121.505412, isPinned: false),
        TheaterInfo(name: "喜滿客絕色影城", address: "台北市萬華區漢中街52號10,11樓", region: "台北西區", latitude: 25.043869, long: 121.507201, isPinned: false),
        TheaterInfo(name: "光點華山電影館", address: "台北市中正區八德路一段1號", region: "台北西區", latitude: 25.044237, long: 121.529452, isPinned: false),
        TheaterInfo(name: "百老匯數位影城", address: "台北市中正區羅斯福路四段200號3-5樓", region: "台北南區", latitude: 25.010721, long: 121.536632, isPinned: false),
        TheaterInfo(name: "東南亞秀泰影城", address: "台北市中正區羅斯福路四段136巷3號", region: "台北南區", latitude: 25.012726, long: 121.535458, isPinned: false),
        TheaterInfo(name: "美麗華大直", address: "台北市中山區敬業三路22號6-9樓", region: "台北北區", latitude: 25.083540, long: 121.556295, isPinned: false),
        TheaterInfo(name: "華威天母", address: "台北市士林區忠誠路二段202號4樓", region: "台北北區", latitude: 25.117260, long: 121.533955, isPinned: false),
        TheaterInfo(name: "欣欣秀泰影城", address: "台北市中山區林森北路247號", region: "台北北區", latitude: 25.054164, long: 121.525973, isPinned: false),
        TheaterInfo(name: "國賓長春影城", address: "台北市中山區長春路176號", region: "台北北區", latitude: 25.054537, long: 121.534124, isPinned: false),
        TheaterInfo(name: "美麗華皇家影城", address: "台北市中山區北安路780號B2", region: "台北北區", latitude: 25.084975, long: 121.553745, isPinned: false),
        TheaterInfo(name: "陽明戲院", address: "台北市士林區文林路113號1樓", region: "台北北區", latitude: 25.088218, long: 121.526122, isPinned: false),
        TheaterInfo(name: "大千電影院", address: "台北市中山區南京東路三段133號", region: "台北北區", latitude: 25.052317, long: 121.541335, isPinned: false),
        TheaterInfo(name: "光點台北電影院", address: "台北市中山區中山北路二段18號", region: "台北北區", latitude: 25.053283, long: 121.522163, isPinned: false),

    ]
}
