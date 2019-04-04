//
//  AutoPayViewController.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/25.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import UIKit

class AutoPayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         print("我是第二页")
        autoModel.getData(parameters: nil, success: { (responseObject) in
            print(responseObject)
        }) { (error) in
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
