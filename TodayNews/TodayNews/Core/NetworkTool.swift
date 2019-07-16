//
//  NetworkTool.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/12.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//请求Server信息
let BASE_URL = "https://is.snssdk.com"
let device_id: Int64 = 6096495334
let iid: Int64 = 5034850950

protocol NetworkToolProtocol {
    /***-----------------我的 mine-----------------***/
    //我的界面 cell的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    //我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
}

extension NetworkToolProtocol {
    /***-----------------我的 mine-----------------***/
    //我的界面 cell的数据
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ()) {
        let url = BASE_URL + "/user/tab/tabs/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, method: HTTPMethod.get, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                DPrint("\(url) 请求失败: \(response.error ?? nil)")
                return
            }
            if let value = response.result.value
            {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    DPrint("请求失败，请稍后重试")
                    return
                }
                if let data = json["data"].dictionary {
                    if let sections = data["sections"]?.array
                    {
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                if let myCellModel = MyCellModel.deserialize(from: row as? Dictionary) {
                                    rows.append(myCellModel)
                                }
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }else {
                    DPrint("数据解析失败")
                }
            }else {
                DPrint("数据解析失败")
            }
        }
    }
    
    //我的关注数据
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ()) {
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                DPrint("\(url) 请求失败: \(response.error ?? nil)")
                return
            }
            if let value = response.result.value
            {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    DPrint("请求失败，请稍后重试")
                    return
                }
                if let datas = json["data"].arrayObject {
                    completionHandler(datas.compactMap({
                        MyConcern.deserialize(from: $0 as? Dictionary)
                    }))
                }else {
                    DPrint("数据解析失败")
                }
            }else {
                DPrint("数据解析失败")
            }
        }
    }
}

struct NetworkTool: NetworkToolProtocol {}
