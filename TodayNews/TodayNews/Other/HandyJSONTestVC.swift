//
//  HandyJSONTestVC.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/11.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import HandyJSON

class BasicTypes: HandyJSON {
    var int: Int  = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!
    
    required init() {}
}

struct BasicTypesStruct: HandyJSON {
    var int: Int = 2
    var doubleOptional: Double?
    var stringImplicitlyUnwrapped: String!
}

enum AnimalType: String, HandyJSONEnum {
    case Cat = "cat"
    case Dob = "dog"
    case Bird = "bird"
}

struct Animal: HandyJSON {
    var name: String?
    var type: AnimalType?
}


class BasicTypesCompose: HandyJSON {
    var bool: Bool = true
    var intOptional: Int?
    var doubleImplicitlyUnwrapped: Double!
    var anyObjectOptional: Any?
    
    var arrayInt: Array<Int> = []
    var arrayStringOptional: Array<String>?
    var setInt: Set<Int>?
    var dictAnyObject: Dictionary<String, Any> = [:]
    
    var nsNumber = 2
    var nsString: NSString?
    
    required init() {}
}

class Animal1: HandyJSON {
    var id: Int?
    var color: String?
    
    required init() {}
}

class Cat: Animal1 {
    var name: String!
    
    required init() {}
}

class Component: HandyJSON {
    var aInt: Int?
    var aString: String?
    
    required init() {}
}

class Composition: HandyJSON {
    var aInt: Int?
    var comp1: Component?
    var comp2: Component?
    
    required init() {}
}

class Composition1: HandyJSON {
    var aInt: Int?
    var comArray: Array<Component>?
    
    required init() {}
}

class HandyJSONTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "HandyJSON Test"
        view.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        
        //Deserialization
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1}"
        if let object = BasicTypes.deserialize(from: jsonString) {
            print("\(object.int),\(object.doubleOptional!),\(object.stringImplicitlyUnwrapped!)")
        }
        //Serialization
        let object = BasicTypes()
        object.int = 1
        object.doubleOptional = 1.1
        object.stringImplicitlyUnwrapped = "hello"
        let objectJson1 = object.toJSON()
        let objectJson2 = object.toJSONString()
        print("\(objectJson1!), \n\(objectJson2!)")
        
        
        //Support Struct
        if let object = BasicTypesStruct.deserialize(from: jsonString) {
            print("BasicTypesStruct: \(object)")
        }
        
        
        //Support Enum Property
        let jsonStringEnum = "{\"type\":\"cat\",\"name\":\"Tom\"}"
        if let animal = Animal.deserialize(from: jsonStringEnum) {
            DPrint("Enum: \(animal)")
            DPrint(animal.type?.rawValue)
        }
        
        
        //Optional/ImplicitlyUnwrappedOptional/Collections/...
        let objectCom = BasicTypesCompose()
        objectCom.intOptional = 1
        objectCom.doubleImplicitlyUnwrapped = 1.1
        objectCom.anyObjectOptional = "StringValue"
        objectCom.arrayInt = [1, 2]
        objectCom.arrayStringOptional = ["a", "b"]
        objectCom.setInt = [1, 2]
        objectCom.dictAnyObject = ["key1": 1, "key2": "stringValue"]
        objectCom.nsNumber = 2
        objectCom.nsString = "nsStringValue"
        
        let jsonStringCom = objectCom.toJSONString()
        if let object = BasicTypesCompose.deserialize(from: jsonStringCom) {
            DPrint("object compose: \(object)")
        }
        
        
        //Designated Path  只解析需要的那一部分
        let jsonStringDesignate = "{\"code\":200,\"msg\":\"success\",\"data\":{\"cat\":{\"id\":12345,\"name\":\"Kitty\"}}}"
        if let cat = Cat.deserialize(from: jsonStringDesignate, designatedPath: "data.cat") {
            DPrint(cat.name)
        }
        
        //Composition Object 组合嵌套对象
        let jsonStringComposition = "{\"num\":12345,\"comp1\":{\"aInt\":1,\"aString\":\"aaaaa\"},\"comp2\":{\"aInt\":2,\"aString\":\"bbbbb\"}}"
        if let composition = Composition.deserialize(from: jsonStringComposition) {
            DPrint(composition)
        }
        let component1 = Component()
        component1.aInt = 1
        component1.aString = "aaaaa"
        let component2 = Component()
        component2.aInt = 2
        component2.aString = "bbbbb"
        let composition1 = Composition1()
        composition1.aInt = 3
        composition1.comArray = [component1, component2]
        var jsonStringComposition1 = composition1.toJSONString()
         jsonStringComposition1 = "{\"comArray\":[{\"aInt\":1,\"aString\":\"aaaaa\"},{\"aInt\":2,\"aString\":\"bbbbb\"}],\"aInt\":3}"
        if let composition = Composition1.deserialize(from: jsonStringComposition1) {
            DPrint(composition)
        }
       
        
        //Inheritance Object 继承对象
        //如果有继承关系，确保父类遵守HandyJSON协议
        let jsonStringInheritance = "{\"id\":12345,\"color\":\"black\",\"name\":\"cat\"}"
        if let cat = Cat.deserialize(from: jsonStringInheritance) {
            DPrint(cat)
        }
        
        
        //JSON Array 对象元素数组
        let jsonArrayString: String? = "[{\"name\":\"Bob\",\"id\":1}, {\"name\":\"Lily\",\"id\":2}, {\"name\":\"Lucy\",\"id\":3}]"
        if let cats = [Cat].deserialize(from: jsonArrayString) {
            cats.forEach({ (cat) in
                DPrint(cat)
            })
        }
        
        
        //********** Mapping 映射 **********//
        //Codable:Swift4.0 Codable。Codable是一个协议，其作用类似于NSPropertyListSerialization 和 NSJSONSerialization，主要用于完成 JSON 和Model之间的转换
        /**
         https://github.com/alibaba/HandyJSON
         https://www.jianshu.com/p/6af6a4d309d3
         https://www.cnblogs.com/yajunLi/p/7121950.html
         https://blog.csdn.net/xiangzhihong8/article/details/83022790
         */
        
        
        
        /****---ObjectMapper---****/
        /*https://github.com/tristanhimmelman/ObjectMapper*/
        
    }
    
}
