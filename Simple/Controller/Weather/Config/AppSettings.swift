//
//  AppSettings.swift
//  Simple
//
//  Created by Next on 2017/11/8.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
class AppSettings {
    
    static let KEY_APP_SETTINGS:String = "key_app_settings"
    
    class func saveAny(key:String, any:Any?) {
        UserDefaults.standard.set(any, forKey: key)
    }
    
    class func getAny(key:String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    class func saveBool(key:String, value:Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getBool(key:String) -> Bool {
        return UserDefaults.standard.bool(forKey:key)
    }
    
    class func saveDouble(key:String, value:Double) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getDouble(key:String) -> Double {
        return UserDefaults.standard.double(forKey:key)
    }
    
    class func saveFloat(key:String, value:Float) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getFloat(key:String) -> Float {
        return UserDefaults.standard.float(forKey:key)
    }
    
    class func saveInt(key:String, value:Int) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func getInt(key:String) -> Int {
        return UserDefaults.standard.integer(forKey:key)
    }
    
    /*--------AppSettings----------*/
    
    class func saveUserName(username:String) {
        saveAny(key: KEY_APP_SETTINGS, any: username)
    }
    
    class func getUserName() -> String {
        return getAny(key: KEY_APP_SETTINGS) as! String
    }
}
