//
//  ZYZNetWork.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/18.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire

public typealias serviceResponseClosure = (_ responseObject: Any?, _ error: Error?) -> Void
public typealias sucessClosure = (_ responseObject: Any?) -> Void
public typealias failClosure = (_ error: Error?) -> Void

public enum HTTP_Method: String {
    
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum NetMethod:Int{
    case GET = 10;
    case POST = 20;
}

class ZYZNetConfig{ // 单独抽离出来，可以继承单独配置host，请求头等
    //
    func FFT_APIServer()->String!{
        return ""
    }
    
   func FFT_HTTPMethod() -> NetMethod{
        return NetMethod.POST
    }
    
    func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!{
        // TODO 签名优化
        return paramters;
    }
    
    
    
    func FFT_setupRequestHeader()->Dictionary<String, String>!{
        let header = ["FuFeiTong": "baseConfig"];
        return header;
    }
    
    func FFT_receiveResponseObject(_ responseObject: DataResponse<Any>?, error errorObj: Error?, success successObj: @escaping sucessClosure, failure failureObj: @escaping failClosure) {
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
    required init(){}
}
