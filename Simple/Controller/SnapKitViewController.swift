//
//  SnapKitViewController.swift
//  Simple
//
//  Created by Next on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit
import SnapKit

class SnapKitViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "SnapKit 演示"
        
        setupView()
    }

    func setupView(){
        /*
         .equalTo：等于
         .lessThanOrEqualTo：小于等于
         .greaterThanOrEqualTo：大于等于
         */
//        var boxOutter = UIView()
//        var boxInner = UIView()
//
//        var sizeConstraint:Constraint!
//
//        boxOutter.backgroundColor = UIColor.orange
//        boxInner.backgroundColor = UIColor.blue
//
//        self.view.addSubview(boxOutter)
//        boxOutter.addSubview(boxInner)
//
//        //创建约束
//        boxOutter.snp.makeConstraints { (make) in
//            make.width.height.equalTo(200)//宽和高等于200
//            make.center.equalTo(self.view)//屏幕垂直水平居中
//        }
//
//        boxInner.snp.makeConstraints { (make) in
//            sizeConstraint = make.width.height.equalTo(100).constraint
////            make.width.height.equalTo(100)
//            make.right.equalTo(0)
//            make.bottom.equalTo(0)
//        }
//
////        sizeConstraint.deactivate()//移除指定的约束
////        sizeConstraint.update(offset: 60)//更新约束
//        boxInner.snp.updateConstraints { (make) in
//            make.width.height.equalTo(150)//更新约束
//        }
//        boxInner.snp.remakeConstraints { (make) in//重做约束
//            make.width.equalTo(100)
//            make.height.equalTo(50)
//            make.center.equalTo(boxOutter)
//            //初始宽、高为100（优先级低）
////            make.width.height.equalTo(100 * self.scacle).priority(250)
//            //最大尺寸不能超过屏幕
//            make.width.height.lessThanOrEqualTo(self.view.snp.width)
//            make.width.height.lessThanOrEqualTo(self.view.snp.height)
//        }
        
        self.view.backgroundColor = UIColor(red: 1/255, green: 170/255, blue: 235/255, alpha: 1)
        
        let formViewHeight = 90
        
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5
        self.formView.layer.borderColor = UIColor.lightGray.cgColor
        self.formView.backgroundColor = UIColor.white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        
        self.formView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            self.topConstraint = make.centerY.equalTo(self.view).constraint
            make.height.equalTo(formViewHeight)
        }
        
        
        self.horizontalLine = UIView()
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(self.horizontalLine)
        
        self.horizontalLine.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(0.5)
            make.centerY.equalTo(self.formView)
        }
        
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named: "settings_hover")
        
        let imgLock = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock.image = UIImage(named: "share_small_hover")
        
        self.txtUserName = UITextField()
        self.txtUserName.delegate = self
        self.txtUserName.placeholder = "请输入用户名"
        self.txtUserName.tag = 100
        self.txtUserName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtUserName.leftViewMode = UITextFieldViewMode.always
        self.txtUserName.returnKeyType = UIReturnKeyType.next
        
        self.txtUserName.leftView?.addSubview(imgUser)
        self.formView.addSubview(self.txtUserName)
        
        self.txtUserName.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(-formViewHeight/4)
        }
        
        self.txtPassWord = UITextField()
        self.txtPassWord.delegate = self
        self.txtPassWord.placeholder = "请输入密码"
        self.txtPassWord.tag = 101
        self.txtPassWord.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtPassWord.leftViewMode = UITextFieldViewMode.always
        self.txtPassWord.returnKeyType = UIReturnKeyType.next
        
        self.txtPassWord.leftView?.addSubview(imgLock)
        self.formView.addSubview(self.txtPassWord)
        
        self.txtPassWord.snp.makeConstraints { (make) in
            make.left.equalTo(self.txtUserName)
            make.right.equalTo(self.txtUserName)
            make.height.equalTo(self.txtUserName)
            make.centerY.equalTo(self.formView).offset(formViewHeight/4)
        }
        
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: UIControlState.normal)
        self.confirmButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        self.confirmButton.addTarget(self, action: #selector(loginConfirm), for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(55)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "用户登录"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 36)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.formView.snp.top).offset(-20)
            make.centerX.equalTo(self.view)
            make.height.equalTo(44)
        }
        
    }
    
    var txtUserName:UITextField!
    var txtPassWord:UITextField!
    var formView:UIView!
    var horizontalLine:UIView!
    var confirmButton:UIButton!
    var titleLabel:UILabel!
    
    var topConstraint:Constraint?
    
    @objc func loginConfirm(){
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        }
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        
        switch tag {
        case 100:
            self.txtPassWord.becomeFirstResponder()
        case 101:
            loginConfirm()
        default:
            print(textField.text ?? "")
        }
        return true
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
