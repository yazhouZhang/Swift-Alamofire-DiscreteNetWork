//
//  NetConfig.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/24.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON

class NetConfigProtocol:ZYZNetConfig{
   //
    override func FFT_APIServer()->String!{
        return "http://rest.zhihuiqiche.com/ZF"
    }
    
    override func FFT_HTTPMethod() -> NetMethod{ // 自定义method类型，方便以后改Alamofire网络库，业务层代码不用动，改封装就可以
        return NetMethod.POST
    }
    
    override func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!{
        // TODO 签名优化
        return paramters;
    }
    
    override func FFT_setupRequestHeader()->Dictionary<String, String>!{
//        var header = ["isJailBreak": "0"];
//        header.updateValue("68", forKey: "appVersion")
//        header.updateValue("APPLE", forKey: "platform")
//        header.updateValue("B83B215F-1A58-437E-9228-53866F30C6A8", forKey: "deviceId")
//        header.updateValue("ACBC32D117EF", forKey: "macAddress")
//        header.updateValue("", forKey: "deviceType")
//        header.updateValue("a03ed0bc75a143debb4ff7aa85ec09fa", forKey: "token")
//        header.updateValue("4763f6527e0da010540fb8f094ae505a", forKey: "sign")
        var header = ["ClientType": "2"];
        header.updateValue("68", forKey: "appVersion")
        header.updateValue("", forKey: "UserId")
        header.updateValue("B83B215F-1A58-437E-9228-53866F30C6A8", forKey: "DeviceToKen")
        header.updateValue("3.5", forKey: "AppVersion")
        header.updateValue("1", forKey: "UpdateTimeStamp")
        header.updateValue("0", forKey: "RequestTimeStamp")
        header.updateValue("a03ed0bc75a143debb4ff7aa85ec09fa", forKey: "token")
        header.updateValue("", forKey: "EquipmentNo")
        header.updateValue("a03ed0bc75a143debb4ff7aa85ec09fa", forKey: "token")
    
        return header;
    }
    
    
    
    override func FFT_receiveResponseObject(_ responseObject: DataResponse<Any>?, error errorObj: Error?, success successObj: @escaping sucessClosure, failure failureObj: @escaping failClosure) {
        if((errorObj) != nil){
//            if(error.code != kCFURLErrorFailingURLErrorKey){
//                  可以做特殊处理，比如埋点，接口异常监测等
//                  数据见const 提供信息
//              }
            failureObj(errorObj)
            return
        }
        
        if(responseObject != nil){
            switch responseObject!.result {
            case .success(let value):
                if let dic = value as? Dictionary<String, Any>{
                    if(dic["ResultCode"] as! Int == 1){
                        successObj(dic["Item"] as AnyObject)
                        return
                    }
                }
    //            if(error.code != kCFURLErrorFailingURLErrorKey){
    //                  可以做特殊处理，比如埋点，接口异常监测等
    //                  数据见const 提供信息
    //              }
                 //这里重新包装Error
                 //error.handleLogicError(msg: dic.Message, respCode:dic.ResultCode);
                  failureObj(errorObj)
            case .failure(_):
                break
            }
        }
    }
    
    required init() {
        super.init()
    }
}
