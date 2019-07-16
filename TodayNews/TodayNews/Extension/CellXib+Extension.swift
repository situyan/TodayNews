//
//  CellXib+Extension.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/15.
//  Copyright © 2019 chisalsoft. All rights reserved.
//  Swift 中的元类型：.Type 与 .self
//  https://blog.csdn.net/weixin_34209406/article/details/87961111

import UIKit

protocol RegisterCellOrNib {
    static var identifier: String { get }
    static var nib: UINib? { get }
}

extension RegisterCellOrNib {
    static var identifier: String {
        return "\(self)"
    }
    static var nib: UINib?  {
        return UINib(nibName: "\(self)", bundle: nil)
    }
}

extension UITableView {
    /**
     *
     * 注册Cell的方法
     *
     * @param cell 泛型 T: UITableViewCell, RegisterCellOrNib
     *
     */
    func cs_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    /// 从缓存池出队已经存在的cell
    func cs_dequeueReusableCell<T: UITableViewCell>() -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
    /// 从缓存池出队已经存在的cell 备注：不要在xib中为Cell设置 identifier  Attributes inspector->Table View Cell->Identifier
    func cs_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    /// 注册Cell方法
    func cs_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellWithReuseIdentifier: T.identifier)
        }
    }
    
    /// 从缓存池出队已经存在的cell
    func cs_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    /// 注册头部
    func cs_registerSupplementaryHeaderView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegisterCellOrNib {
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }
    
    /// 获取可重用的头部
    func cs_dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) ->T where T: RegisterCellOrNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

protocol NibLoadable {}

extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}
