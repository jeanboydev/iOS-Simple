//
//  RightViewController.swift
//  Simple
//
//  Created by Next on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class RightViewController: UITableViewController {

    let historyCity = ["北京","上海","广州","深圳","南京", "武汉"]
    let section0Title = ["提醒","设置","支持"]
    let section0Img = ["reminder","setting_right","contact"]
    
    var controller:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = slideControllerBgColor
        let nib = UINib(nibName: "RightTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "rightCell")
        
        self.tableView.rowHeight = 70
        self.tableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        }else{
            return 2 + historyCity.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath) as! RightTableViewCell
        
        if indexPath.section == 0 {
            cell.itemLabel.text = section0Title[indexPath.row]
            cell.indicatorImage.image = UIImage(named: section0Img[indexPath.row])
            cell.deleteImage.isHidden = true
        }else{
            if indexPath.row == 0 {
                cell.itemLabel.text = "添加"
                cell.indicatorImage.image = UIImage(named: "addcity")
                cell.deleteImage.isHidden = true
            }else if indexPath.row == 1 {
                cell.itemLabel.text = "定位"
                cell.indicatorImage.image = UIImage(named: "city")
                cell.deleteImage.isHidden = true
            }else{
                cell.itemLabel.text = historyCity[indexPath.row - 2]
                cell.indicatorImage.image = UIImage(named: "city")
                cell.deleteImage.isHidden = false
            }
        }
        
        return cell
    }
    
    //表头高度
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(0)
        }else{
            return CGFloat(30)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
            return label
        }else{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
            label.text = "城市管理"
            label.textAlignment = .center
            label.backgroundColor = UIColor.black
            label.textColor = UIColor.white
            return label
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("item 点击==="+String(indexPath.section)+"====="+String(indexPath.row))
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                print("添加城市")
                let storyBoard = UIStoryboard(name: "AddNewCity", bundle: Bundle.main)
                let addNewCityController = storyBoard.instantiateViewController(withIdentifier: "AddNewCityController") as! AddNewCityController
                
                self.controller?.present(addNewCityController, animated: true, completion: {
                    
                })
                
            }else if indexPath.row == 1 {
                print("自动定位")
            }else{
                print("历史城市")
            }
        }
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
