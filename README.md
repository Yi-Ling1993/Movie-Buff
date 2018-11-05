# Taipei Movies [<img src = "https://i.imgur.com/ETMOSLq.png" width="150px" align=center >](https://itunes.apple.com/us/app/taipei-movies/id1439176860?l=zh&ls=1&mt=8)<img src ="https://i.imgur.com/mu0BHX5.jpg" width="50px" align=center>
讓使用者能夠快速知道台北各大電影院當前上映和即將上映的電影，並得知相關電影資訊及觀看預告片。可透過篩選電影院所在區域及日期獲得電影時刻表，並提供電影院訂票連結以及呼叫 Google Map 進行導航。
* 串接 The Open Movie Database API 及 The Movie Database API 實現 GET 請求，呈現電影相關資料及預告片
* 呼叫 Google Map 進行導航
* 使用 Firebase 作為後端資料庫
* 使用 WebKit 實作 Webview 將使用者導至該電影院訂票網站
* 使用 Swiftlint 管理 Code 的撰寫
* 使用 Fabric Crashlytics 
### Notes:
```
如要下載專案，請自行申請 Google MAP API 金鑰，並依照 AppDelegate 使用的參數名稱加入金鑰的值。
另外請自行下載 Firebase 的 GoogleService-Info.plist。
```
## Features & ScreenShots
### 選單列
* 從側邊選單列切換四個主要頁面：上映中、本週上映、即將上映、電影院。  

<img src ="https://i.imgur.com/1cRKX4Y.gif" width="270px">

### 上映中、本週上映、即將上映頁面
* 使用者可以切換海報至感興趣之電影並閱讀其相關資訊。
* 找到感興趣之電影，進入時刻表畫面可篩選區域電影院及日期以獲得目標時刻，接著按“訂票”連結至此電影院之訂票網站。
* 可先觀看電影預告決定是否對此電影有興趣。  

<img src ="https://i.imgur.com/UfSUQOr.gif" width="270px"> <img src ="https://i.imgur.com/M9vlm6B.gif" width="270px"> <img src ="https://i.imgur.com/7Ux8fg6.gif" width="270px">

### 電影院頁面
* 使用者可直接進入特定電影院找尋此電影院當前上映之電影。
* 點擊地圖可開啟 Google Map 導航至此電影院。
* 進入特定電影院選特定電影後能看見基本電影資訊及整週電影時刻。  

<img src ="https://i.imgur.com/UgKVZ9w.png" width="270px"> <img src ="https://i.imgur.com/HIV8G5z.png" width="270px">




## Libraries
* SwiftLint
* GoogleMaps
* GooglePlaces
* WKAwesomeMenu
* SnapKit
* FSPagerView
* YouTubePlayer-Swift
* Firebase/Core
* Firebase/Database
* Alamofire
* Kingfisher
* Fabric
* Crashlytics
* lottie-ios

## Requirement
* iOS 12.0+
* Xcode 10.0+

## Version
* 1.1.0 - 2018/10/25
  * 優化使用者體驗  

* 1.0.4 - 2018/10/19
  * First release 





## Contacts
**Yi-Ling Liu**  
**email:** liuyiling1993@gmail.com


