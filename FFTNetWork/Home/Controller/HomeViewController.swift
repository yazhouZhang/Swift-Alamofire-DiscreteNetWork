//
//  HomeViewController.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/25.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var dataArr:Array<HomeModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let dic:Dictionary<String,String> = ["id": " ","iShowType": "3","sTitle": " ","sSearchKey": " ","iImgType": "1","PageIndex": "0"];

        HomeModel.getModel(parameters: nil, success: { (model) -> Void in
            self.dataArr = model
            print("我是第一页")
            print(self.dataArr)
            print(self.dataArr[0].sValue)
        }) { (error) in

        }
    }
    
//        HomeModel<[HomeModel]>.FFT_requestModelAPI(api: "/Config/GetCarTypeList" ,parameters: nil, success: { (model) in
//            if let dataArr:[HomeModel] = model.Item as? [HomeModel]{
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
