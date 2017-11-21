//
//  DataWarpper.swift
//  Simple
//
//  Created by Next on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
class DataWrapper<T:Codable>: Codable {
    
    var success:String?
    var result:T?
    
}
