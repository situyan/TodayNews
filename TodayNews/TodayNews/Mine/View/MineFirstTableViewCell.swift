//
//  MineFirstTableViewCell.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/15.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import Kingfisher

class MineFirstTableViewCell: UITableViewCell, RegisterCellOrNib {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var concernCollectionView: UICollectionView!
    ///点击Cell事件闭包
    var myConcernSelected: ((_ myConcern: MyConcern) -> ())?
    
    var myConcerns = [MyConcern]() {
        didSet {
            concernCollectionView.reloadData()
        }
    }
    
    var myCellModel = MyCellModel() {
        didSet {
            titleLabel.text = myCellModel.text
            subTitleLabel.text = myCellModel.grey_text
        }
    }
    
    /// 当只关注一个用户的时候，需要设置
    var myConcern = MyConcern() {
        didSet {
            rightImageView.kf.setImage(with: URL(string: myConcern.icon))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        concernCollectionView.collectionViewLayout = MyConcernFlowLayout()
        concernCollectionView.delegate = self
        concernCollectionView.dataSource = self
        concernCollectionView.cs_registerCell(cell: MyConcernCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class MyConcernFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = CGSize(width: 58, height: 74)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets.zero
        scrollDirection = .horizontal
    }
}

extension MineFirstTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cs_dequeueReusableCell(indexPath: indexPath) as MyConcernCollectionViewCell
        cell.myConcern = myConcerns[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        myConcernSelected?(myConcerns[indexPath.item])
    }
}
