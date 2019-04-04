//
//  ViewController.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/18.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import UIKit
import HandyJSON
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }

    @IBAction func jumpToMainApp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "main_app", sender: self)
    }
    @IBAction func goToMainApp(_ sender: Any) {
        self.performSegue(withIdentifier: "main_app", sender: self)
    }
    
}

