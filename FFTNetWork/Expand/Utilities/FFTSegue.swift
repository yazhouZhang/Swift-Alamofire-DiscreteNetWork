//
//  FFTSegue.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/25.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import UIKit

class FFTSegue: UIStoryboardSegue {
        /**
         执行
         */
        override func perform() {
            let source = self.source
            let destination = self.destination
            source.present(destination, animated: false, completion: nil)
        }
}
