//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Raymond on 2016/12/28.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组对应的房间信息
    var room_list : [[String : Any]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict:dict))
            }
        }
    }
    /// 组显示的标题  
    var tag_name : String = ""
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    /// 构造函数
    override init() {
        super.init()
    }
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
