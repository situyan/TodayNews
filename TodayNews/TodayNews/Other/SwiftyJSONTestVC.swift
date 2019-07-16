//
//  SwiftyJSONTestVC.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/10.
//  Copyright © 2019 chisalsoft. All rights reserved.
//  SwiftyJSON详解：http://www.hangge.com/blog/cache/detail_968.html

import UIKit
import SwiftyJSON

class SwiftyJSONTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "SwiftyJSON Test"
        view.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        
        let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        guard let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) else {
            debugPrint("jsonData 初始化失败")
            return;
        }
        debugPrint("jsonData is \(jsonData)")
        
        //使用系统方法JSONSerialization取第一条联系人的第一个电话号码
        if let userArray = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: AnyObject]] {
            let phones = userArray[0]["phones"] as? [[String: AnyObject]]
            let number = phones?[0]["number"] as? String
            // 找到电话号码
            DPrint("JSONSerialization>>>第一个联系人的第一个电话号码：\(number ?? "没有")")
            //使用optional简化一下
            if let number = (userArray[0]["phones"] as? [[String: AnyObject]])?[0]["number"] as? String {
                print("JSONSerialization>>>第一个联系人的第一个电话号码：", number)
            }
        }
        
        //使用SwiftyJSON解析
        //不用担心数组越界，不用判断节点，拆包什么的
        var json = try! JSON(data: jsonData)
        if let number = json[0]["phones"][0]["number"].string {
            // 找到电话号码
            DPrint("SwiftyJSON>>>第一个联系人的第一个电话号码：\(number)")
        }else {
            //如果没取到值，还可以走到错误处理来了，打印一下看看错在哪：
            // 打印错误信息
            DPrint("\(json[0]["phones"][0]["number"])")
        }
        
        
        //可选值获取（Optional getter）
        //通过.number, .string, .bool, .int, .uInt,.float, .double, .array, .dictionary, int8, Uint8, int16, Uint16, int32, Uint32, int64, Uint64等方法获取到的是可选择值
        //int
        if let age = json[0]["age"].int {
            print(age)
        } else {
            //打印错误信息
            print(json[0]["age"])
        }
        //不可选值获取（Non-optional getter）
        //使用 xxxValue 这样的属性获取值，如果没获取到的话会返回一个默认值。省得我们再判断拆包了
        //If not a Number or nil, return 0
        let age: Int = json[0]["age"].intValue
        //If not a String or nil, return ""
        let name: String = json[0]["name"].stringValue
        //If not a Array or nil, return []
        let list: Array<JSON> = json[0]["phones"].arrayValue
        //If not a Dictionary or nil, return [:]
        let phone: Dictionary<String, JSON> = json[0]["phones"][0].dictionaryValue
        DPrint("age \(age), name \(name), list \(list), phone \(phone)")
        
        
        //获取原始数据（Raw object）
        let jsonObject1 = json.object as AnyObject
        let jsonObject2 = json.rawValue as AnyObject
        //JSON转换Data
        let data = try! json.rawData()
        //JSON转换String字符串  只有这个目前看来有实际作用
        let string = json.rawString()
        print("")
        
        
        //设置值
        json[0]["age"].int = 101
        json[0]["name"].string =  "hangge.com"
        json[0]["phones"].arrayObject = [["name":"固话", "number":110],["name":"手机", "number":120]]
        json[0]["phones"][0].dictionaryObject = ["name":"固话", "number":100]
        
        
        //下标访问（Subscript）
        //可以通过数字、字符串、数组类型的下标访问JSON数据的层级与属性。比如下面三种方式的结果都是一样的：
        //方式1
        let number1 = json[0]["phones"][0]["number"].stringValue
        //方式2
        let number2 = json[0,"phones",0,"number"].stringValue
        //方式3
        let keys:[JSONSubscriptType] = [0,"phones",0,"number"]
        let number3 = json[keys].stringValue
        print("")
        
        
        //循环遍历JSON对象中的所有数据
        for (index, subJson) in json {
            print("index:\(index), subJson:\(subJson)")
        }
        //如果JSON数据是字典类型（Dictionary）
        for (key,subJson):(String, JSON) in json[0] {
            print("\(key)：\(subJson)")
        }
        
        
        //构造创建JSON对象数据
        //1、空的JSON对象
        let testJson: JSON? =  nil
        //2、使用简单的数据类型创建JSON对象
        let testJson1: JSON = "I'm a son"
        let testJson2: JSON =  12345
        let testJson3: JSON =  true
        let testJson4: JSON =  2.8765
        //使用数组或字典数据创建JSON对象
        let testJson5: JSON =  ["I":"am", "a":"son"]
        let testJson6: JSON =  ["I", "am", "a", "son"]
        var testJson7: JSON =  ["name": "Jack", "age": 25, "list": ["a", "b", "c", ["what": "this"]]]
        testJson7["list"][3]["what"] = "that"
        testJson7["list",3,"what"] = "that"
        let path:[JSONSubscriptType] = ["list",3,"what"]
        json[path] = "that"
        print("testJson7:\(testJson7)")
    }
    

}
