//
//  HigherOrderFunctionTestVC.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/15.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class HigherOrderFunctionTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "HigherOrderFunction Test"
        view.backgroundColor = UIColor(r: 247, g: 247, b: 247)
        
        /** ==========高阶遍历函数========== **/
        /* https://blog.csdn.net/mo_xiao_mo/article/details/78424714 */
        /**
         map函数 map 方法获取一个闭包表达式作为其唯一参数。 数组中的每一个元素调用一次该闭包函数，并返回该元素所映射的值。
         简单说就是数组中每个元素通过某个方法进行转换，最后返回一个新的数组。
         */
        let prices = [20, 30, 40]
        let strs = prices.map({ "$\($0)" })
        print(strs)
        
        let values = [4, 6, 9]
        let squares = values.map( { $0 * $0})
        print(squares)
        
        /**
         flatMap函数 flatMap 方法同 map 方法比较类似，只不过它返回后的数组中不存在 nil（自动把 nil 给剔除掉），同时它会把 Optional 解包。
         */
        let array1 = ["Apple", "Orange", "Grape", ""]
        let arr1 = array1.map { (a) -> Int? in
            let length = a.count
            guard length > 0 else { return nil }
            return length
        }
        print("arr1: \(arr1)")
        let arr2 = array1.flatMap { (a) -> Int? in
            let length = a.count
            guard length > 0 else { return nil }
            return length
        }
        print("arr2: \(arr2)")
        let arr3 = array1.compactMap { (a) -> Int? in
            let length = a.count
            guard length > 0 else { return nil }
            return length
        }
        print("arr3: \(arr3)")
        
        //flatMap 还能把数组中存有数组的数组（二维数组、N维数组）一同打开变成一个新的数组。
        let array2 = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let arr11 = array2.map{ $0 }   // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let arr12 = array2.flatMap{ $0 } // [1, 2, 3, 4, 5, 6, 7, 8, 9]
        print("arr11: \(arr11) \n arr12: \(arr12)")
        
        
        /**
         filter函数 filter 方法用于过滤元素，即筛选出数组元素中满足某种条件的元素。
         */
        let pricesf = [20,30,40]
        let resultf = pricesf.filter({ $0 > 25})
        print("filter resultf \(resultf)")
        
        
        /**
         reduce函数 reduce 方法把数组元素组合计算为一个值，并且会接受一个初始值，这个初始值的类型可以和数组元素类型不同。
         */
        let pricesr = [20, 30, 40]
        var sum = pricesr.reduce(0) { (a1, a2) -> NSInteger in
            return a1 + a2
        }
        print("reduce sum \(sum)")
        sum = pricesr.reduce(10) { $0 + $1}
        print("reduce sum \(sum)")
        
        //简化操作
        //高阶函数的组合使用、链式调用
        //https://blog.csdn.net/mo_xiao_mo/article/details/78424714
        
    }
    
}
