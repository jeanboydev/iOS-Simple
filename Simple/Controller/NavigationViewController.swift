//
//  NavigationViewController.swift
//  Simple
//
//  Created by Next on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.title = "标题"
        
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        label.backgroundColor = UIColor.red
        label.text = "hello word"
        self.view.addSubview(label)
        
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 30))
        button.setTitle("切换", for: UIControlState.normal)
        button.backgroundColor = UIColor.brown
        button.addTarget(self, action: #selector(changeController), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        let barButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBack))
        self.navigationItem.backBarButtonItem = barButtonItem
//        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func changeController(){
        let viewController = NavigationViewController()
        viewController.hidesBottomBarWhenPushed = true//隐藏tab bar controller
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func onBack(){
        print("onback")
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
