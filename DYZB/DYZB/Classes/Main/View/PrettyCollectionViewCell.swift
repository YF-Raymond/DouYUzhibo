//
//  PrettyCollectionViewCell.swift
//  DYZB
//
//  Created by Raymond on 2016/12/28.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: CollectionBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var anchorCityBtn: UIButton!
    
    // MARK:- 模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            // 显示所在城市
            anchorCityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
