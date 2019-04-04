//
//  ZYZNetWorkCore.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/19.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON

extension BaseModel{ // private 不能夸文件访问，不能加，而且extension 不能够重写，所以ok
    
    class public func transformMethod<T:ZYZNetConfig>(_ netConfig:T)->HTTPMethod{
        switch netConfig.FFT_HTTPMethod() {
        case .GET:
            return HTTPMethod.get
        case .POST:
            return HTTPMethod.post
        default:
            return HTTPMethod.get
        }
    }
       
    static public func FFT_URLStringWithAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String!)->String!{
        return netConfig.FFT_APIServer().appending(url)
    }

    static public func FFT_URLStringForAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String!,parameters parameter:Dictionary<String, Any>!)->String!{
        let urlStr:String! = netConfig.FFT_APIServer().appending(url)
        let parameterDic:Dictionary<String, Any>! = netConfig.FFT_signParameters(parameter)
        var items:Array<URLQueryItem> = Array.init()
        for (key,value) in parameterDic{
            assert((value as? String) == nil,"URL API 拼接必须 value as? String 成功")
            items.append(URLQueryItem.init(name: key, value: value as? String))
        }
        var components:URLComponents! = URLComponents.init(string: urlStr)
        components.queryItems = items;
        return components.string;
    }
    
     static public func FFT_requestAPI(api url: String!, parameters parameterDic: Dictionary<String, Any>?, success sucessClosure : @escaping sucessClosure, fail failClosure: @escaping failClosure){
        self.FFT_requestAPI(NetConfigProtocol.init(), api: url,parameters: parameterDic, success: sucessClosure, fail: failClosure)
    }
    
     static public func FFT_requestAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String!, parameters parameterDic: Dictionary<String, Any>?, success sucessClosure : @escaping sucessClosure, fail failClosure: @escaping failClosure){
        self.FFT_requestAPI(netConfig, api: url, httpType: netConfig.FFT_HTTPMethod(), headers: nil, parameters: parameterDic, success: sucessClosure, fail: failClosure)
    }
    
     static public func FFT_requestAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String! ,httpType method: NetMethod, parameters parameterDic: Dictionary<String, Any>?, success sucessClosure : @escaping sucessClosure, fail failClosure: @escaping failClosure){
        self.FFT_requestAPI(netConfig, api: url, httpType: method, headers: nil, parameters: parameterDic, success: sucessClosure, fail: failClosure)
    }

    static public func FFT_requestAPI<T:ZYZNetConfig>(_ netConfig:T, api url: String! ,httpType method: NetMethod, headers header:Dictionary<String, String>?, parameters parameterDic: Dictionary<String, Any>?, success sucessClosure : @escaping sucessClosure, fail failClosure: @escaping failClosure){
        let urlStr:String! = self.FFT_URLStringWithAPI(netConfig, api: url)
        let parameters = netConfig.FFT_signParameters(parameterDic)
        var headerDic:Dictionary<String, String>! = netConfig.FFT_setupRequestHeader()
        if(header != nil){
            for (key,value) in header!{
                headerDic.updateValue(value, forKey: key)
            }
        }
        Alamofire.request(urlStr, method:self.transformMethod(netConfig), parameters: parameters, encoding: JSONEncoding.default, headers: headerDic).responseJSON(completionHandler:{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                /*{
                 Count = 0;
                 Item = "";
                 Message =     {
                 bStop = 0;
                 iStopTime = 0;
                 sContent = "";
                 sModelName = "";
                 sTitle = "";
                 };
                 PageCount = 0;
                 ResultCode = 3;
                 UpdateTimeStamp = 0;
                 } */
                netConfig.FFT_receiveResponseObject(response, error: nil, success: sucessClosure, failure: failClosure)
                break
            case .failure(let error):
                print(error)
                netConfig.FFT_receiveResponseObject(response, error: error, success: sucessClosure, failure: failClosure)
                break
            }
            
            //            case .success( _):
            //                self.FFT_receiveResponseObject(response.result.value, error: nil, success: (_ response.result.value: AnyObject) -> Void, failure: <#T##((Error) -> Void)##((Error) -> Void)##(Error) -> Void#>)
            //                if let items = response.result.value as? NSArray{
            //                    //遍历数组得到每一个字典模型
            //                    for dict in items{
            //                        print(dict)
            //                    }
            //                }
            
        })
    }
//
//   /***********************************************************************************
//    to do
//    Alamofire.upload data || stream 上传资源
//    是一样的原理
//    *********************************************************************************/
//}
}
