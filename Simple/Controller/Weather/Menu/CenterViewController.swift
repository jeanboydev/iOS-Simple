//
//  WeatherMainViewController.swift
//  Simple
//
//  Created by Next on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import CoreLocation//导入定位框架

class CenterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    var myTableView:UITableView!
    
    let header = MJRefreshNormalHeader()
    
    var locationManager:CLLocationManager!//拿到位置的经纬度
    //根据经纬度解析地名
    let geocoder:CLGeocoder = CLGeocoder()
    
    var currentCity:String!
    
    var hud:MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.title = "Weather"
        self.view.backgroundColor = UIColor.purple
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        
        self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.hud.label.text = "正在定位"
        
        self.getLocation()//开始定位
    }
    
    
    func getLocation(){
        print("==================定位方法开始")
        //判断定位是否打开
        if !CLLocationManager.locationServicesEnabled() {
            print("==================定位未打开")
        }else{
            print("==================开始执行定位")
            self.locationManager = CLLocationManager()
            
            
            //ios8之后定位需要用户授权
            if #available(iOS 8.0.0, *) {
                print("==================开始执行定位需要申请权限")
                self.locationManager.requestAlwaysAuthorization()
            }
            
            self.locationManager.startUpdatingLocation()
            self.locationManager.delegate = self
            
            
            print("==================定位已开始")
        }
    }
    
    //定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:==="+error.localizedDescription)
        self.hud.label.text = "定位失败！"
    }
    //定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            let locationInfo = locations.last
            
            manager.stopUpdatingLocation()//停止定位
            geocoder.reverseGeocodeLocation(locationInfo!, completionHandler: { (placeMarks, error) in
                if placeMarks!.count > 0 {
                    let place:CLPlacemark = placeMarks![0]
                    print("位置信息："+String(describing: place.country)+"-"+String(describing: place.locality))
                    
                    //回到主线程更新ui
                    DispatchQueue.main.async {
                        self.hud.label.text = "定位成功，正在读取天气信息..."
                        self.currentCity = place.locality?.replacingOccurrences(of: "市", with: "")
                        print("=======定位到的城市信息======"+self.currentCity)
                        self.initView()
                    }
                }
            })
        }
    }
    
    
    func initView(){
        self.layoutNavigationBar(date: DateUtil.getNowSimpleDateString(), weekDay: DateUtil.getWeekDayString(date:  Date()), cityName: self.currentCity)
        
        self.myTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        self.view.addSubview(self.myTableView)
        self.myTableView.backgroundColor = UIColor.purple
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        let nib = UINib(nibName: "MainTableViewCell", bundle: Bundle.main)
        self.myTableView.register(nib, forCellReuseIdentifier: "mainCell")
        
        self.myTableView.separatorStyle = .none//隐藏间隔线

        //使用第三方下拉刷新库
        self.myTableView.mj_header = header
        header.refreshingBlock = {
            print("下拉刷新")
            self.requeseCurrentWeather(cityName: self.currentCity)
        }
        
        requeseCurrentWeather(cityName: self.currentCity)
    }
    
    func requeseCurrentWeather(cityName:String) {
        let url = "http://api.k780.com:88/?app=weather.today&weaid=\(cityName)&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
        
        NetUtil.get(url: url, onSuccess: { (result) in
            print("======success====="+result)
            let resultData = JsonUtil.toObject(DataWrapper<WeatherInfo>.self, result)
            
            if resultData.success == "1" {
                let weatherInfo:WeatherInfo = resultData.result!
                self.title = weatherInfo.weather
                
                self.layoutNavigationBar(date: DateUtil.getNowSimpleDateString(), weekDay: DateUtil.getWeekDayString(date:  Date()), cityName: cityName)
                
                self.header.endRefreshing()
                
                self.hud.hide(animated: true)
            }else{
                print("=====解析失败=========")
            }
        }) { (error) in
            print("====error==="+error.localizedDescription)
        }
        
        request7DayWeather(cityName: cityName)
    }

    func request7DayWeather(cityName:String) {
        let url = "http://api.k780.com:88/?app=weather.future&weaid=\(cityName)&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json"
        
        NetUtil.get(url: url, onSuccess: { (result) in
            print("====7天天气信息===="+result)
            let resultData = JsonUtil.toObject(DataWrapper<Array<WeatherInfo>>.self, result)
            if resultData.success == "1" {
                let weatherInfoArray:Array<WeatherInfo> = resultData.result!
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: leftControllerNotify), object: nil, userInfo: ["data":weatherInfoArray])
            }else{
                print("=====解析失败=========")
            }
        }) { (error) in
            print("====error==="+error.localizedDescription)
        }
        
    }
    
    
    func layoutNavigationBar(date:String, weekDay:String, cityName:String){
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        let categoryBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "category_hover"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(chooseDateAction))
        let dateBarItem = UIBarButtonItem(title: date+" "+weekDay, style: UIBarButtonItemStyle.plain, target: self, action: #selector(chooseDateAction))
        
        self.navigationItem.leftBarButtonItems = [categoryBarItem, dateBarItem]
        
        let shareBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "share_small_hover"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(shareAction))
        let cityBarItem = UIBarButtonItem(title: cityName, style: UIBarButtonItemStyle.plain, target: self, action: nil)
        let settingsBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings_normal"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(settingsAction))
        
        self.navigationItem.rightBarButtonItems = [settingsBarItem, cityBarItem, shareBarItem]
    }
    
    @objc func chooseDateAction(sender:UIBarButtonItem){
        
    }
    
    @objc func shareAction(sender:UIBarButtonItem){
        
    }
    
    @objc func settingsAction(sender:UIBarButtonItem){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
