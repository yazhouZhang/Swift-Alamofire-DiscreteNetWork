//
//  File.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/27.
//  Copyright © 2019 FuFeiTong. All rights reserved.
// static func  / class final func  静态方法禁止被重写

import Foundation
import Alamofire
import HandyJSON
typealias BaseProtocol = HandyJSON
class BaseModel<value:Any>:BaseProtocol & ZYZNetWorkProtocol{
    typealias valueBlock = ((BaseService<value>)->())?
    typealias protocolClosure = valueBlock
    typealias modelClosure = (DataResponse<BaseService<value>>) -> Void
   // typealias netConfig = ZYZNetConfig<T>
//    class func FFT_APIServer()->String!{
//        return ""
//    }
//    
//   class func FFT_signParameters(_ paramters: Dictionary<String, Any>?)->Dictionary<String, Any>!{
//        // TODO 签名优化
//        return paramters;
//    }
//    
//   class func FFT_setupRequestHeader()->Dictionary<String, String>!{
//        let header = ["FuFeiTong": "baseConfig"];
//        return header;
//    }
//    
//    
//    
//   class func FFT_receiveResponseObject(_ responseObject: DataResponse<Any>?, error errorObj: Error?, success successObj: @escaping sucessClosure, failure failureObj: @escaping failClosure) {
//        if((errorObj) != nil){
//            //            if(error.code != kCFURLErrorFailingURLErrorKey){
//            //                  可以做特殊处理，比如埋点，接口异常监测等
//            //                  数据见const 提供信息
//            //              }
//            failureObj(errorObj)
//            return
//        }
//        
//        if(responseObject != nil){
//            switch responseObject!.result {
//            case .success(let value):
//                if let dic = value as? Dictionary<String, Any>{
//                    if(dic["ResultCode"] as! Int == 1){
//                        successObj(dic["Item"] as AnyObject)
//                        return
//                    }
//                }
//                //            if(error.code != kCFURLErrorFailingURLErrorKey){
//                //                  可以做特殊处理，比如埋点，接口异常监测等
//                //                  数据见const 提供信息
//                //              }
//                //这里重新包装Error
//                //error.handleLogicError(msg: dic.Message, respCode:dic.ResultCode);
//                failureObj(errorObj)
//            case .failure(_):
//                break
//            }
//        }
//    }
    required public init() {}
}

/// 对Alamofire进行扩展
extension DataRequest{
    @discardableResult
    public func FFT_responseString<T:Any>(
        completionHandler: @escaping (DataResponse<BaseService<T>>) -> Void)
        -> Self {
            let serializer = DataResponseSerializer<BaseService<T>> { (request, response, data, error) -> Result<BaseService<T>> in
                let requestUrl : String = String(describing: request?.url?.absoluteString ?? "")
                guard error == nil else {
                    print("请求失败:\(requestUrl)")
                    return .failure(FFTError.string(string: "网络请求异常"))
                }
                if let response = response, FFT_emptyDataStatusCodes.contains(response.statusCode) { return .success(BaseService<T>()) }
                guard let validData = data else {
                    print("请求失败:\(requestUrl)")
                    return .failure(FFTError.string(string: "数据请求异常"))
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: validData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    let model = BaseService<T>.deserialize(from: json)
                    if model != nil {
                        model?.requestUrl = requestUrl
                        return .success(model!)
                    }else{
                        print("请求失败:\(requestUrl)")
                        return .failure(FFTError.string(string: "数据请求异常"))
                    }
                } catch {
                    print("请求失败:\(requestUrl)")
                    return .failure(FFTError.string(string: "网络请求异常"))
                }
            }
            return response(
                queue: DispatchQueue.main,
                responseSerializer: serializer,
                completionHandler: completionHandler
            )
    }
}
/// 对错误信息进行扩展
enum FFTError: Error {
    case string(string:String)
}
private let FFT_emptyDataStatusCodes: Set<Int> = [204, 205]
