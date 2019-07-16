//
//  MyCellModel.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/12.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import Foundation
import HandyJSON


struct MyCellIconUrl: HandyJSON {
    var url: String = ""
}

struct MyCellIconItem: HandyJSON {
    var height: CGFloat = 0
    var width: CGFloat = 0
    var radius: Int = 0
    var uri: String = ""
    var url_list: Array<MyCellIconUrl> = []
}

struct MyCellIcon: HandyJSON {
    var day: MyCellIconItem?
    var night: MyCellIconItem?
}

struct MyCellModel: HandyJSON {
    var grey_text: String = ""
    var text: String = ""
    var url: String = ""
    var key: String = ""
    var tip_new: Int = 0
    var tip_text: String = ""
    var icons: MyCellIcon?
}

struct UserAuthInfo: HandyJSON {
    var auth_type: Int = 0
    var auth_info: String = ""
}

struct MyConcern: HandyJSON {
    var name: String = ""
    var url: String = ""
    var total_count: Int = 0
    var description: String = ""
    var time: String = ""
    var type: String = ""
    var icon: String = ""
    var userid: Int = 0
    ///是否是VIP会员
    var is_verify: Bool = false
    var media_id: Int = 0
    var tips: Bool = false
    var id: Int = 0
    var user_auth_info = UserAuthInfo()
}
