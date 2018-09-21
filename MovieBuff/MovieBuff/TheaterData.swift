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
}

class TheaterData {
    
    static let instance = TheaterData()
    
    let theaterInfo: [TheaterInfo] = [
        TheaterInfo(name: "台北信義威秀", address: "台北市信義區松壽路16,18號", region: "台北東區"),
        TheaterInfo(name: "國賓微風影城", address: "台北市松山區復興南路一段39號(微風廣場7樓)", region: "台北東區"),
        TheaterInfo(name: "誠品電影院", address: "台北市信義區菸廠路88號B2", region: "台北東區"),
        TheaterInfo(name: "新民生戲院", address: "台北市松山區民生東路五段190號3樓", region: "台北東區"),
        TheaterInfo(name: "喜滿客京華影城", address: "台北市松山區八德路四段138號B1", region: "台北東區"),
        TheaterInfo(name: "喜樂時代影城", address: "台北市南港區忠孝東路7段299號11-14樓", region: "台北東區"),
        TheaterInfo(name: "梅花數位影院", address: "台北市大安區和平東路三段63號2樓", region: "台北東區"),
        TheaterInfo(name: "總督影城", address: "台北市松山區長安東路二段219號5樓之1", region: "台北東區"),
        TheaterInfo(name: "哈拉影城", address: "台北市內湖區康寧路三段72號", region: "台北東區"),
        TheaterInfo(name: "台北新光影城", address: "台北市萬華區西寧南路36號4樓,5樓", region: "台北西區"),
        TheaterInfo(name: "樂聲影城", address: "台北市萬華區武昌街二段85號", region: "台北西區"),
        TheaterInfo(name: "台北日新威秀", address: "台北市萬華區武昌街二段87號", region: "台北西區"),
        TheaterInfo(name: "台北京站威秀", address: "台北市大同區市民大道一段209號5樓", region: "台北西區"),
        TheaterInfo(name: "in89豪華數位影城", address: "台北市萬華區武昌街二段89號", region: "台北西區"),
        TheaterInfo(name: "真善美戲院", address: "台北市萬華區漢中街116號", region: "台北西區"),
        TheaterInfo(name: "國賓戲院", address: "台北市萬華區成都路88號", region: "台北西區"),
        TheaterInfo(name: "今日秀泰影城", address: "台北市萬華區峨眉街52號", region: "台北西區"),
        TheaterInfo(name: "喜滿客絕色影城", address: "台北市萬華區漢中街52號10,11樓", region: "台北西區"),
        TheaterInfo(name: "光點華山電影館", address: "台北市中正區八德路一段1號", region: "台北西區"),
        TheaterInfo(name: "百老匯數位影城", address: "台北市中正區羅斯福路四段200號3-5樓", region: "台北南區"),
        TheaterInfo(name: "東南亞秀泰影城", address: "台北市中正區羅斯福路四段136巷3號", region: "台北南區"),
        TheaterInfo(name: "美麗華大直", address: "台北市中山區敬業三路22號6-9樓", region: "台北北區"),
        TheaterInfo(name: "華威天母", address: "台北市士林區忠誠路二段202號4樓", region: "台北北區"),
        TheaterInfo(name: "欣欣秀泰影城", address: "台北市中山區林森北路247號", region: "台北北區"),
        TheaterInfo(name: "國賓長春影城", address: "台北市中山區長春路176號", region: "台北北區"),
        TheaterInfo(name: "美麗華皇家影城", address: "台北市中山區北安路780號B2", region: "台北北區"),
        TheaterInfo(name: "陽明戲院", address: "台北市士林區文林路113號1樓", region: "台北北區"),
        TheaterInfo(name: "大千電影院", address: "台北市中山區南京東路三段133號", region: "台北北區"),
        TheaterInfo(name: "光點台北電影院", address: "台北市中山區中山北路二段18號", region: "台北北區"),

    ]
}
