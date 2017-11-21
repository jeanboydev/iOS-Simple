//
//  LockViewController.swift
//  Simple
//
//  Created by Next on 2017/11/2.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class LockViewController: UIViewController, LockViewDelegate {
    
    var actionCode:Int = 0
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelTips: UILabel!
    
    //忘记密码
    @IBAction func forgotSecret() {
        
        savePath(path: nil)
        setupView()
    }
    
    
    var secretSaveCount:Int = 0
    var isSecretSetting:Bool = false
    let paramKey:String = "path"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        print("=====viewDidLoad=====")
        
        //转场传值调用
//        performSegue(withIdentifier: "<#T##String#>", sender: <#T##Any?#>)
        
        print("=====viewWillDisappear=====")
        
        setupView()
    }
    
    func setupView(){
        switch actionCode {
        case 100:
            labelTitle.text = "设置密码"
            labelTips.text = "请设置新密码"
            labelTips.textColor = UIColor.blue
            if isHadPath() {
                labelTips.text = "请先输入旧密码"
                labelTips.textColor = UIColor.orange
            }
            break
        case 101:
            labelTitle.text = "验证密码"
            labelTips.text = "请滑动输入密码"
            labelTips.textColor = UIColor.blue
            if !isHadPath() {
                labelTips.text = "请先设置密码"
                labelTips.textColor = UIColor.orange
            }
            break
        case 102:
            labelTitle.text = "修改密码"
            labelTips.text = "请输入旧密码"
            labelTips.textColor = UIColor.blue
            if !isHadPath() {
                labelTips.text = "请先设置密码"
                labelTips.textColor = UIColor.orange
            }
            break
        default:
            break
        }
    }
    
    //修改状态栏模式
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent//高亮模式
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func lockViewDidComplete(lockView: LockView, path: NSString) {
        //处理回调
        if path.length < 4 {
            labelTips.text = "至少需要 4 个点！"
            labelTips.textColor = UIColor.red
            return
        }
        
        if !isHadPath() {//没有旧密码直接保存
            savePath(path: path as String)
            labelTips.text = "请重复输入刚才的密码"
            labelTips.textColor = UIColor.orange
            secretSaveCount += 1
            isSecretSetting = true
        } else {//已经设置密码，验证密码
            if checkPath(path: path as String) {//验证成功
                if secretSaveCount > 0 {//密码二次验证
                    labelTips.text = "密码设置成功!"
                    labelTips.textColor = UIColor.green
                    secretSaveCount = 0
                    isSecretSetting = false
                    autoBack()
                } else {//重新设置密码操作
                    labelTips.text = "请输入新密码"
                    labelTips.textColor = UIColor.blue
                    savePath(path: nil)//清空密码
                }
            } else {//验证失败
                if secretSaveCount > 0 {//密码二次验证
                    labelTips.text = "两次输入的密码不一致！"
                    labelTips.textColor = UIColor.red
                    secretSaveCount += 1
                } else {
                    labelTips.text = "旧密码输入不正确！"
                    labelTips.textColor = UIColor.red
                }
            }
        }
    }
    
    func autoBack(){
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                if self.isSecretSetting {//密码设置中途退出，清空
                    self.savePath(path: nil)
                }
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func savePath(path:String?){//保存密码
        UserDefaults.standard.set(path, forKey: paramKey)
    }
    
    func checkPath(path:String) -> Bool {//校验密码
        if !isHadPath() {
            return false
        }
        let cachePath:String = getPath()!
        return cachePath.isEqual(path)
    }
    
    func getPath() -> String? {//获取密码
        return UserDefaults.standard.string(forKey: paramKey)
    }
    
    func isHadPath() -> Bool {
        return getPath() != nil && !(getPath()!.isEmpty)
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
