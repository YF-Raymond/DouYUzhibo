//
//  HeaderCollectionReusableView.swift
//  DYZB
//
//  Created by Raymond on 2016/12/27.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit



class HeaderCollectionReusableView: UICollectionReusableView {
    // MARK:- 控件属性
    @IBOutlet weak var tagnameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    // MARK:- 定义属性
    var group : AnchorGroup? {
        didSet {
            tagnameLabel.text = group?.tag_name
            iconView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}
