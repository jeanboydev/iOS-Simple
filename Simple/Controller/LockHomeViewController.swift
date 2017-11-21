//
//  ViewController.swift
//  Simple
//
//  Created by Next on 2017/11/1.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class LockHomeViewController: UIViewController {
    
    //按钮点击回调
//    @IBAction func btnClick(_ sender: UIButton) {
//        switch sender.tag {
//        case 100://设置密码
//            break
//        case 101://验证密码
//            break
//        case 102://修改密码
//            break
//        default:
//            break
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("====准备跳转=====")
        let dest = segue.destination as! LockViewController
        
        if segue.identifier == "settingsToLockView" {
            dest.actionCode = 100
        } else if segue.identifier == "verifyToLockView" {
            dest.actionCode = 101
        } else if segue.identifier == "modifyToLockView" {
            dest.actionCode = 102
        }
        
    }
    
    //返场方法手动定义
    @IBAction func toClose(segue:UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

