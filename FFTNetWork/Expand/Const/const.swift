//
//  const.swift
//  FFTNetWork
//
//  Created by zhangyazhou on 2019/2/19.
//  Copyright © 2019 FuFeiTong. All rights reserved.
//

import Foundation
import HandyJSON

public typealias modelProtocol = BaseService

//            [Request]: POST http://rest.zhihuiqiche.com/ZF/Config/GetCarTypeList
//            [Response]: <NSHTTPURLResponse: 0x600003f31440> { URL: http://rest.zhihuiqiche.com/ZF/Config/GetCarTypeList } { Status Code: 200, Headers {
//                "Access-Control-Allow-Origin" =     (
//                "*"
//                );
//                "Cache-Control" =     (
//                "no-cache"
//                );
//                "Content-Length" =     (
//                500
//                );
//                "Content-Type" =     (
//                "application/json; charset=utf-8"
//                );
//                Date =     (
//                "Tue, 26 Feb 2019 09:16:17 GMT"
//                );
//                Expires =     (
//                "-1"
//                );
//                Pragma =     (
//                "no-cache"
//                );
//                Server =     (
//                "Microsoft-IIS/7.5"
//                );
//                "X-AspNet-Version" =     (
//                "4.0.30319"
//                );
//                "X-Powered-By" =     (
//                "ASP.NET"
//                );
//            } }
//        [Data]: 500 bytes
//        [Result]: SUCCESS: {
//            Count = 4;
//            Item =     (
//                {
//                    dMaxValue = 0;
//                    dMinValue = 0;
//                    iValueType = 1;
//                    sId = "";
//                    sImage = "";
//                    sValue = "\U8f7f\U8f66";
//            },
//                {
//                    dMaxValue = 0;
//                    dMinValue = 0;
//                    iValueType = 1;
//                    sId = "";
//                    sImage = "";
//                    sValue = SUV;
//            },
//                {
//                    dMaxValue = 0;
//                    dMinValue = 0;
//                    iValueType = 1;
//                    sId = "";
//                    sImage = "";
//                    sValue = MPV;
//            },
//                {
//                    dMaxValue = 0;
//                    dMinValue = 0;
//                    iValueType = 1;
//                    sId = "";
//                    sImage = "";
//                    sValue = "\U9762\U5305\U8f66";
//            }
//            );
//            Message =     {
//                bStop = 0;
//                iStopTime = 0;
//                sContent = "";
//                sModelName = "";
//                sTitle = "";
//            };
//            PageCount = 0;
//            ResultCode = 1;
//            UpdateTimeStamp = 0;
//        }
//            }
