//
//  NetUtil.swift
//  Simple
//
//  Created by Next on 2017/11/7.
//  Copyright © 2017年 jeanboy. All rights reserved.
//

import Foundation
class NetUtil {
    
    class func get(url:String, onSuccess:@escaping (_ result:String) -> (), onError:@escaping (_ error:Error) -> ()) {
        let urlEncode = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlEncode!) { (data, response, error) in
            if let data = data {
                if let result = String(bytes: data, encoding: String.Encoding.utf8) {//success
                    //请求完毕，主线程更新
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                }
            }else{//failure
                DispatchQueue.main.async {
                    onError(error!)
                }
            }
        }
        dataTask.resume()//开始请求
    }
}
