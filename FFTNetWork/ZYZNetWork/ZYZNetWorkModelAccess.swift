//
//  NetWorkModelAccess.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/18.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//类可以使用关键字static class 修饰方法,但是结构体、枚举只能使用关键字static修饰

import Foundation
import Alamofire
import HandyJSON

extension BaseModel {
    
    static public func FFT_requestModelAPI(api url: String! ,parameters parameterDic: Dictionary<String, Any>?, success:valueBlock,failture:((String)->())?){
        self.FFT_requestModelAPI(NetConfigProtocol.init(), api: url, parameters: parameterDic, success: success,failture: failture);
    }
    
    static public func FFT_requestModelAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String! ,parameters parameterDic: Dictionary<String, Any>?, success:valueBlock,failture:((String)->())?){
        self.FFT_requestModelAPI(netConfig, api: url, httpType: netConfig.FFT_HTTPMethod(), parameters: parameterDic, success: success,failture: failture);
    }

    static public func FFT_requestModelAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String! ,httpType method: NetMethod,parameters parameterDic: Dictionary<String, Any>?, success:valueBlock,failture:((String)->())?){
        self.FFT_requestModelAPI(netConfig, api: url, httpType: method, headers: nil, parameters: parameterDic, success: success,failture: failture)
    }

    static public func FFT_requestModelAPI<T:ZYZNetConfig>(_ netConfig:T,api url: String! ,httpType method: NetMethod, headers header:Dictionary<String, String>?, parameters parameterDic: Dictionary<String, Any>?, success:valueBlock,failture:((String)->())?){
        let urlStr:String! = netConfig.FFT_APIServer().appending(url)
        //self.FFT_URLStringWithAPI(netConfig, api: url)
        let parameters = netConfig.FFT_signParameters(parameterDic)
        var headerDic:Dictionary<String, String>! = netConfig.FFT_setupRequestHeader()
        if(header != nil){
            for (key,value) in header!{
                headerDic.updateValue(value, forKey: key)
            }
        }
//        let dataRequest:DataRequest = Alamofire.request(urlStr, method:method, parameters: parameters, encoding: JSONEncoding.default, headers: headerDic)
        Alamofire.request(urlStr, method:self.transformMethod(netConfig), parameters: parameters, encoding: JSONEncoding.default, headers: headerDic).FFT_responseString { (model:DataResponse<BaseService<value>>) in
            if success != nil,model.value != nil{
                success!(model.value!)
            }
            if failture != nil,model.error != nil{
                let error: FFTError = model.error as! FFTError
                switch  error {
                case  .string(let string):
                    failture!(string)
                }
            }
        }
    }
}

