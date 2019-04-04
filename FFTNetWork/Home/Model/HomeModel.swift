//
//  HomeModel.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/25.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import HandyJSON

class HomeModel:HandyJSON{
    typealias homeModelClosure = (_ responseObject: [HomeModel]) -> Void
    var sValue:String! = ""//(描述值)
    var sImage:String? //图片路径
    var dMinValue:Double!  = 0.0//最小价格
    var dMaxValue :Double! = 0.0 //(最大价格)
    var iValueType:Int! = 1 //值类型： 1 单值 |2 区间值 |3 图片
    
    required public init() {}
}

 extension HomeModel{
    
    class func getModel(parameters dic:Dictionary<String, Any>?, success:@escaping homeModelClosure,failture:((String)->())?){
        
        BaseModel<[HomeModel]>.FFT_requestModelAPI(api: "/Config/GetCarTypeList", parameters: dic, success: { (model) in
            if let dataArr:[HomeModel] = model.Item{
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
        // 等同于下面这种写法
//        let netConfig = NetConfigProtocol.init()
//        //let netConfig = ZYZNetConfig.init()
//         BaseModel<[HomeModel]>.FFT_requestModelAPI(netConfig, api: api ,parameters: dic, success: { (model) in
//            if let dataArr:[HomeModel] = model.Item{
//                success(dataArr)
//                return
//            }
//            if failture != nil{
//                failture!("失败")
//            }
//        }){ (error) in
//            if failture != nil{
//                failture!("失败")
//            }
//        }
        
//        HomeModel<[HomeModel]>.FFT_requestModelAPI(api: api ,parameters: dic, success: { (model) in
//            if let dataArr:[HomeModel] = model.Item as! [HomeModel]{
//                success(dataArr)
//                return
//            }
//            if failture != nil{
//                failture!("失败")
//            }
//        }){ (error) in
//            if failture != nil{
//                failture!("失败")
//            }
//        }
     
//        BaseModel<[HomeModel]>.FFT_requestModelAPI(api: api ,parameters: dic, success: { (model) in
//            if let dataArr:[HomeModel] = model.Item{
//                success(dataArr)
//                return
//            }
//            if failture != nil{
//                failture!("失败")
//            }
//        }){ (error) in
//            if failture != nil{
//                failture!("失败")
//            }
//        }
       //self.init().FFT_requestModelAPI(api: api ,parameters: dic, completion: completionClosure)
    }
}
