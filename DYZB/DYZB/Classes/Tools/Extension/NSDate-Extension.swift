//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by Raymond on 2016/12/28.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        // 时间间隔
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
