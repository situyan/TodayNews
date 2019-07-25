//
//  SettingModel.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/25.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import Foundation
import HandyJSON

struct SettingModel: HandyJSON {
    var title: String = ""
    var subtitle: String = ""
    var rightTitle: String = ""
    var isHiddenRightTitle: Bool = false
    var isHiddenSubtitle: Bool = false
    var isHiddenRightArrow: Bool = false
    var isHiddenSwitch: Bool = false
}
