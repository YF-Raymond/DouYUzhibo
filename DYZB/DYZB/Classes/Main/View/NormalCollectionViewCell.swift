//
//  NormalCollectionViewCell.swift
//  DYZB
//
//  Created by Raymond on 2016/12/27.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class NormalCollectionViewCell: CollectionBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var roomnameLabel: UILabel!
    
    // MARK:- 模型属性
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            // 房间名
            roomnameLabel.text = anchor?.room_name
        }
    }
}
