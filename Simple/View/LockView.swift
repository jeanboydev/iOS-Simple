//
//  LockView.swift
//  Simple
//
//  Created by Next on 2017/11/3.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import UIKit

//声明代理，类似接口回调
@objc protocol LockViewDelegate {
    func lockViewDidComplete(lockView:LockView, path:NSString)
}

class LockView: UIView {

    @IBOutlet weak var lockDelegate:LockViewDelegate!
    
    var btnSeletedArray:NSMutableArray = []
    
    //storyboard，xib关联必须实现该方法
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView(){
        let space = 100//间距
        let startX = 44
        let startY = 24
        let btnWidth = 100
        let btnHeight = 100
        var secret = 0
        for row in 0...2 {//3行
            for col in 0...2 {//3列
                let tempX = startX + col * space
                let tempY = startY + row * space
                let btn:UIButton = UIButton(type: UIButtonType.custom)
                btn.isUserInteractionEnabled = false//关闭交互
                btn.frame = CGRect(x: tempX, y: tempY, width: btnWidth, height: btnHeight)
                btn.setImage(UIImage.init(named: "gesture_node_normal"), for: UIControlState.normal)
                btn.setImage(UIImage.init(named: "gesture_node_highlighted"), for: UIControlState.selected)
                secret += 1
                btn.tag = secret
                self.addSubview(btn)
            }
        }
    }
    
    //获取触摸点
    func getPointFromTouches(touches:Set<UITouch>) -> CGPoint {
        let touch:UITouch? = touches.first
        let point = touch?.location(in: touch!.view)
        return point!
    }
    
    //通过点获取按钮
    func getButtonFromPoint(point:CGPoint) -> UIButton? {
        for btn in self.subviews {//遍历子view
            if btn.frame.contains(point) {
                return btn as? UIButton
            }
        }
        return nil
    }
    
    //添加划过的按钮
    func addButtonToArray(button:UIButton) {
        button.isSelected = true//设置状态为选中
        btnSeletedArray.add(button)//添加到集合中
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //开始触摸
        print("======touchesBegan=====")
        let point:CGPoint = getPointFromTouches(touches: touches)
        let button:UIButton? = getButtonFromPoint(point: point)
        if button != nil && btnSeletedArray.contains(button!) == false {
            addButtonToArray(button: button!)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //移动
        print("======touchesMoved=====")
        let point:CGPoint = getPointFromTouches(touches: touches)
        let button:UIButton? = getButtonFromPoint(point: point)
        if button != nil && button?.isSelected == false {
            addButtonToArray(button: button!)
        }
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //触摸结束
        print("======touchesEnded=====")
        if lockDelegate != nil {
            let path:NSMutableString = NSMutableString()
            if self.btnSeletedArray.count > 0 {
                for button in btnSeletedArray {
                    //把按钮的tag值拼接到可变字符串
                    print("======button tag========" + String((button as! UIButton).tag))
                    path.appendFormat("%1d", (button as! UIButton).tag)
                }
            }
            
            if path.length > 0 {
                //发送消息
                lockDelegate.lockViewDidComplete(lockView: self, path: path)
            }
        }
        //把选中的按钮设为默认状态
        if self.btnSeletedArray.count > 0 {
            for button in btnSeletedArray {
                (button as! UIButton).isSelected = false
            }
        }
        self.btnSeletedArray.removeAllObjects()
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //触摸取消
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if self.btnSeletedArray.count == 0 {
            return//没有选中的按钮直接返回
        }
        let path:UIBezierPath = UIBezierPath()//创建路径
        for index in 0..<self.btnSeletedArray.count {
            let button:UIButton = self.btnSeletedArray[index] as! UIButton
            if index == 0 {
                path.move(to: button.center)
            } else {
                path.addLine(to: button.center)
            }
        }
        
        path.lineWidth = 8
        UIColor.blue.set()//设置颜色
        path.stroke()//绘制
    }
 

}
