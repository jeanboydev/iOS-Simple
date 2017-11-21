//
//  DateUtil.swift
//  Simple
//
//  Created by Next on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
class DateUtil {
    
    class func getSimpleDateString(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ch")
        dateFormatter.dateFormat = "MM.dd"
        return dateFormatter.string(from:date)
    }
    
    class func getNowSimpleDateString() -> String{
        return getSimpleDateString(date: Date())
    }
    
    class func getWeekDayString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ch")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from:date)
    }
}
