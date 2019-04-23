//
//  ZYZNetWorkProtocol.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/18.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import Alamofire

protocol ZYZNetWorkProtocol{
    associatedtype protocolClosure
    associatedtype modelClosure
    //协议内容T
    /** API 服务器域名
     *
     *  实现例如 https://www.shfft.com
     */
    func FFT_APIServer()->String!
    
   
    func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!
    

    
    func FFT_setupRequestHeader()->Dictionary<String, String>!
    
    
  
    func FFT_receiveResponseObject(_ responseObject: DataResponse<Any>? ,error errorObj: Error? ,success successObj: @escaping sucessClosure,failure failureObj: @escaping failClosure)
    
  
     func FFT_parseResponseObject(_ responseObject: DataRequest, T value: modelClosure,sucess success: protocolClosure,failture:((String)->())?)
   
}

extension ZYZNetWorkProtocol{
    // public typealias sucessClosure = (BaseService<value>) -> Void
    func FFT_APIServer()->String!{
        return "http://rest.zhihuiqiche.com/ZF"
    }
    
    func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!{

        return paramters;
    }
    
    
    
    func FFT_setupRequestHeader()->Dictionary<String, String>!{
       
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
                        successObj(dic["Item"])
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
    
    func FFT_parseResponseObject(_ responseObject: DataRequest,T value: modelClosure, sucess success: protocolClosure, failture: ((String) -> ())?) {
    }
    
}

