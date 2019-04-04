//
//  autoModel.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/3/4.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
class autoModel{
    
}
extension autoModel{
    
    class func getData(parameters dic:Dictionary<String, Any>?, success:@escaping sucessClosure,failture:((String)->())?){
        BaseModel<Any>.FFT_requestAPI(api: "/Config/GetCarTypeList", parameters: dic, success: { (responseObject) in
            if let dataArr = responseObject as? Array<AnyObject>{
                success(dataArr)
                return
            }
            if failture != nil{
                failture!("失败")
            }
        }) {(error) in
            if failture != nil{
                failture!("失败")
            }
        }
    }
}
