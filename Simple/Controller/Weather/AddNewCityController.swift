//
//  AddNewCityTableViewController.swift
//  Simple
//
//  Created by Next on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class AddNewCityController: UITableViewController {

    var defaultCityArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.view.backgroundColor = UIColor.black
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.separatorStyle = .none
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        headerView.backgroundColor = UIColor.black
        
        let searchInput = UITextField(frame: CGRect(x: 20, y: 14, width: self.view.bounds.width - 40, height: 30))
        searchInput.backgroundColor = UIColor.white
        searchInput.layer.cornerRadius = 15
        searchInput.layer.masksToBounds = true
        searchInput.leftView = UIImageView(image: UIImage(named: "search_b"))
        searchInput.leftViewMode = .always
        searchInput.placeholder = "城市名称或拼音"
        
        headerView.addSubview(searchInput)
        
        self.tableView.tableHeaderView = headerView
        
        let path = Bundle.main.path(forResource: "default-city", ofType: "plist")
        let array = NSArray(contentsOfFile: path!)
        for element in array! {
            self.defaultCityArray.append(String(describing: element))
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.defaultCityArray.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        cell.backgroundColor = UIColor.black
        cell.textLabel?.textColor = UIColor.white
        if indexPath.row == 0 {
            cell.textLabel?.text = "自动定位"
            cell.imageView?.image = UIImage(named: "city")
        }else{
            cell.textLabel?.text = self.defaultCityArray[indexPath.row - 1]
            cell.imageView?.image = nil
        }
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
