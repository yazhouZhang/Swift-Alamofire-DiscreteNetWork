//
//  BaseService.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/18.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import HandyJSON
//typealias BaseProtocol = ZYZNetWorkProtocol & HandyJSON
typealias serviceProtocol = HandyJSON
public class BaseService<T:Any>: serviceProtocol {
    var Count:Int = 4
    var Item:T?
    var Message:ErrorMessage?
    var PageCount:Int = 0;
    var ResultCode:Int = 1;
    var UpdateTimeStamp:Int = 0;
    var requestUrl:String?
    //...自定义数据
     required public init() {}
}

class ErrorMessage:HandyJSON{
    var bStop: Bool! = false //是否展示
    var iStopTime: Int! = 3 //展示时间
    var sContent: String?//展示内容
    var sModelName: String? = "" //
    var sTitle:String? = "" //展示标题
    required init() {}
}
