//
//  MineVC.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/9.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class MineVC: UITableViewController {
   
    /// 存储 cell的数据
    var dataSource = [[MyCellModel]]()
    /// 存储我的关注数据
    var concerns = [MyConcern]()
    /// 懒加载 头部
    private lazy var headerView: NoLoginHeaderView = {
        let headerView =  NoLoginHeaderView.loadViewFromNib()
        return headerView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
//        tableView.register(UINib(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "mineCell")
//        tableView.register(UINib(nibName: "MineFirstTableViewCell", bundle: nil), forCellReuseIdentifier: "mineFirstCell")
        tableView.cs_registerCell(cell: MineTableViewCell.self)
        tableView.cs_registerCell(cell: MineFirstTableViewCell.self)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = DefaultColor
        tableView.separatorStyle = .none
        
        //获取我的Cell数据
        NetworkTool.loadMyCellData { (sections) in
            let string = "{\"text\":\"我的关注\",\"grey_text\":\"\"}"
            let myConcern = MyCellModel.deserialize(from: string)
            var myConcerns = [MyCellModel]()
            myConcerns.append(myConcern!)
            self.dataSource.append(myConcerns)
            self.dataSource += sections
            self.tableView.reloadData()
            DPrint(self.dataSource)
            //获取我的关注数据
            NetworkTool.loadMyConcern(completionHandler: { (myConcerns) in
                self.concerns = myConcerns
                self.tableView.reloadSections(IndexSet(integer: 0), with: UITableView.RowAnimation.automatic)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        //处理缓存超出情况
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        //销毁处理
    }
}

extension MineVC {
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let theModel = dataSource[indexPath.section][indexPath.row]
        if indexPath.section == 0 && indexPath.row == 0
        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "mineFirstCell") as! MineFirstTableViewCell
            let cell = tableView.cs_dequeueReusableCell() as MineFirstTableViewCell
            cell.titleLabel?.text = theModel.text
            cell.concernCollectionView.isHidden = (concerns.count == 0 || concerns.count == 1) ? true : false
            if concerns.count == 1 {
                cell.myConcern = concerns[0]
            }
            if concerns.count > 1 {
                cell.myConcerns = concerns
            }
            cell.myConcernSelected = { [weak self] (myConcern: MyConcern) in
                DPrint("点击了\(myConcern.name)")
//                let userDetailVC = UserDetailViewController2()
//                userDetailVC.userId = $0.userid
//                self?.navigationController?.pushViewController(userDetailVC, animated: true)
            }
            
            return cell
        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "mineCell") as! MineTableViewCell
        let cell = tableView.cs_dequeueReusableCell() as MineTableViewCell
        cell.titleLabel?.text = theModel.text
        cell.subTitleLabel.text = theModel.grey_text
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        headerView.backgroundColor = DefaultColor
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return (concerns.count == 0 || concerns.count == 1) ? 40 : 114
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 && indexPath.row == 1 {
            self.navigationController?.pushViewController(HigherOrderFunctionTestVC(), animated: true)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let totalOffset = kMyHeaderViewHeight + abs(offsetY)
            let f = totalOffset / kMyHeaderViewHeight
            headerView.bgImageView.frame = CGRect(x: -SCREEN_WIDTH * (f - 1) * 0.5, y: offsetY, width: SCREEN_WIDTH * f, height: totalOffset)
//            headerView.bgImageView.frame = CGRect(x: 0, y: offsetY, width: SCREEN_WIDTH * 1, height: totalOffset)
        }
    }
}
