//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by Raymond on 2016/12/28.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class RecommendViewModel {
    // MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}
// MARK:- 发送网络请求
extension RecommendViewModel {
    func requestData(finishCallback:@escaping ()->()) {
        // 0.定义参数
        let parameters =  ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        // 1.创建 DispatchGroup
        let dispatchGroup = DispatchGroup()
        // 2.请求第一部分推荐数据
        dispatchGroup.enter()   // 进组
        NetworkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            // 1.将 result转成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 2.根据 data 获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3.遍历字典,将字典转成模型对象
            self.bigDataGroup.tag_name = "最热"
            self.bigDataGroup.icon_name = "home_header_hot"
            for dict in dataArray {
                let anchors = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchors)
            }
            dispatchGroup.leave() // 离开组
        }
        
        // 3.请求第二部分颜值数据
        dispatchGroup.enter()   // 进组
        NetworkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result) in
            // 1.将 result转成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 2.根据 data 获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3.遍历字典,将字典转成模型对象
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "columnYanzhiIcon"
            for dict in dataArray {
                let anchors = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchors)
            }
            dispatchGroup.leave() // 离开组
        }
        // 4.请求2-12部分游戏数据
        dispatchGroup.enter()   // 进组
        NetworkTools.requsetData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .get, parameters: parameters) { (result) in
            // 1.将 result转成字典
            guard let resultDict = result as? [String : Any] else { return }
            // 2.根据 data 获取数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 3.遍历数组,获取字典,且将字典转成模型对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            dispatchGroup.leave() // 离开组
        }
        // 所有数据都请求到后进行排序
        dispatchGroup.notify(queue: .main) { 
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
}
