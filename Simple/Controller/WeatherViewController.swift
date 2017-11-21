//
//  MapViewController.swift
//  Simple
//
//  Created by Next on 2017/11/6.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var centerViewController:CenterViewController!
    var leftViewController:LeftViewController!
    var rightViewController:RightViewController!
    var mainViewController:UIViewController!
    
    var panSpeed:CGFloat!
    var condition:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panSpeed = 0.5
        condition = 0
        
        self.centerViewController = CenterViewController()
        self.mainViewController = UINavigationController(rootViewController: centerViewController)
        
        self.leftViewController = LeftViewController()
        self.view.addSubview(self.leftViewController.view)
        
        self.rightViewController = RightViewController()
        self.view.addSubview(self.rightViewController.view)
        self.rightViewController.controller = self
        
        self.view.addSubview(self.mainViewController.view)
        
        self.leftViewController.view.isHidden = true
        self.rightViewController.view.isHidden = true
        
        
        //添加滑动手势
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        self.mainViewController.view.addGestureRecognizer(pan)
    }

    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func panAction(sender:UIPanGestureRecognizer){
        print("滑动屏幕")
        let point = sender.translation(in: sender.view)
        self.condition = point.x * self.panSpeed + self.condition

        if (sender.view?.frame.origin.x)! >= CGFloat(0) {
            //向左滑动
            sender.view?.center = CGPoint(x: (sender.view?.center.x)! + point.x * panSpeed, y: (sender.view?.center.y)!)
            sender.setTranslation(CGPoint.init(x: 0, y: 0), in: self.view)
            self.rightViewController.view.isHidden = true
            self.leftViewController.view.isHidden = false
        } else {
            //向右滑动
            sender.view?.center = CGPoint(x: (sender.view?.center.x)! + point.x * panSpeed, y: (sender.view?.center.y)!)
            sender.setTranslation(CGPoint.init(x: 0, y: 0), in: self.view)
            self.rightViewController.view.isHidden = false
            self.leftViewController.view.isHidden = true
        }
        
        //手指离开操作
        if sender.state == .ended{
            if self.condition > UIScreen.main.bounds.width * CGFloat(0.5) * self.panSpeed {
                self.showLeftView()
            }else if self.condition < UIScreen.main.bounds.width * CGFloat(-0.5) * self.panSpeed {
                self.showRightView()
            }else{
                self.showMainView()
            }
        }
        
    }
    
    func showMainView(){
        UIView.beginAnimations(nil, context: nil)
        self.mainViewController.view.center = CGPoint.init(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        UIView.commitAnimations()
    }
    
    func showLeftView(){
        UIView.beginAnimations(nil, context: nil)
        self.mainViewController.view.center = CGPoint.init(x: UIScreen.main.bounds.width * CGFloat(1.5) - CGFloat(60), y: UIScreen.main.bounds.height/2)
        UIView.commitAnimations()
    }
    
    func showRightView(){
        UIView.beginAnimations(nil, context: nil)
        self.mainViewController.view.center = CGPoint.init(x: CGFloat(60) - UIScreen.main.bounds.width * CGFloat(0.5), y: UIScreen.main.bounds.height/2)
        UIView.commitAnimations()
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
