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
    
    /**
     参数签名
     
     @param paramters 需要签名的参数字典
     @return 返回签名后的参数字典
     */
    func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!
    

    /**
     创建网络连接默认的参数构造函，每次网络连接都将回调该函数
     此方法可选实现
     @param requestSerializer 需要设置参数的requestSerializer
     */
    func FFT_setupRequestHeader()->Dictionary<String, String>!
    
    
    /**
     处理server返回的response，非Model化处理
     
     @param responseObject server返回的response
     @param task task
     @param error error
     @param success 处理正常
     @param failure 处理异常
     */
    func FFT_receiveResponseObject(_ responseObject: DataResponse<Any>? ,error errorObj: Error? ,success successObj: @escaping sucessClosure,failure failureObj: @escaping failClosure)
    
    /**
     处理server返回的response，Model化处
     
     @param responseObject server返回的response
     @return Model化的数据
     */
     func FFT_parseResponseObject(_ responseObject: DataRequest, T value: modelClosure,sucess success: protocolClosure,failture:((String)->())?)
   
}

extension ZYZNetWorkProtocol{
    // public typealias sucessClosure = (BaseService<value>) -> Void
    func FFT_APIServer()->String!{
        return "http://rest.zhihuiqiche.com/ZF"
    }
    
    func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!{
        // TODO 签名优化
        return paramters;
    }
    
    
    
    func FFT_setupRequestHeader()->Dictionary<String, String>!{
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
        //        responseObject<(DataResponse<BaseService<value>>)>.FFT_responseString{(model:modelClosure) in
        //
        //        }
        //        if (!responseObject || [responseObject isEqual:[NSNull null]]) {
        //            return nil;
        //        } else if ([responseObject isKindOfClass:[NSArray class]]) {
        //            if (self != [NSString class] && self != [NSNumber class]) {
        //                return [NSArray yy_modelArrayWithClass:self json:responseObject];
        //            }
        //        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
        //            return [self yy_modelWithJSON:responseObject];
        //        }else if ([responseObject isKindOfClass:[NSString class]]) {
        //            return responseObject;
        //        }
        //        return nil;
        
        //        if(responseObject is NSNull){
        //            return nil;
        //        }
        //        if let data = responseObject as? Array<AnyObject>{
        //           // JSONDeserializer<type(of: self): HandyJSON>.
        //           // [Self].deserialize(from:data)
        //           // HandyJSON.deserialize
        //         // let resultArray = [HomeModel].deserialize(from:data)
        //            let resultArray = BaseService<T>.deserialize(from:data)
        //            //[Self].deserialize(from:data)
        //            return resultArray as AnyObject;
        //        }
        //
        //        if let data = responseObject as? Dictionary<String,Any>{
        //            let modeltool = JSONDeserializer<BaseService<T>>.deserializeFrom(dict: data)
        //            return modeltool as AnyObject
        //        }
        //        if let data = responseObject as? String{
        //            return responseObject;
        //        }
        //        print("______")
        //
        //        print(responseObject)
        //
        //        print(self)
        //        print(type(of: self))
        //        return nil;
    }
    
}

