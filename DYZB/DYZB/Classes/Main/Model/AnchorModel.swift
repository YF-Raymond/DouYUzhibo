//
//  AnchorModel.swift
//  DYZB
//
//  Created by Raymond on 2016/12/28.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class AnchorModel: NSObject { 
    /// 房间id
    var room_id : Int = 0
    /// 房间名
    var room_name : String = ""
    /// 房间图片对应的 URL
    var vertical_src : String = ""
    /// 判断是电脑直播(0)/手机直播(1)
    var isVertical : Int = 0
    /// 主播昵称
    var nickname : String = ""
    /// 在线观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
