//
//  LeftViewController.swift
//  Simple
//
//  Created by Next on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class LeftViewController: UITableViewController {
    
    var dataSource = [WeatherInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = slideControllerBgColor
        
        let nib = UINib(nibName: "LeftTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "leftCell")
        
        self.tableView.rowHeight = 100
        self.tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: NSNotification.Name(rawValue: leftControllerNotify), object: nil)
    }
    
    
    @objc func refreshData(sender:Notification){
        let  weatherInfoArray = sender.userInfo!["data"] as! Array<WeatherInfo>
        
        if dataSource.count > 0 {
            dataSource.removeAll()
        }
        
        for weatherInfo in weatherInfoArray {
            dataSource.append(weatherInfo)
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath) as! LeftTableViewCell
        
        let weatherInfo = self.dataSource[indexPath.row]
        cell.dateLabel.text = weatherInfo.days
        cell.weekDayLabel.text = weatherInfo.week
        cell.temperatureLabel.text = weatherInfo.temp_low! + "~" + weatherInfo.temp_high!
        cell.weatherLabel.text = weatherInfo.weather
        
        if indexPath.row == 0 {
            cell.weekDayLabel.text = "今天"
        }else if indexPath.row == 1 {
            cell.weekDayLabel.text = "明天"
        }
        
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
