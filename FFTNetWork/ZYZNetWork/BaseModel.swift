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
