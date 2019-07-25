//
//  SettingTableVC.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/25.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class SettingTableVC: UITableViewController {

    /// 存储 plist 文件中的数据
    var dataSources = [[SettingModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "设置"
        let path = Bundle.main.path(forResource: "SettingPlist", ofType: "plist")
        let cellPlist = NSArray(contentsOfFile: path!) as! [Any]
        dataSources = cellPlist.compactMap( { section in
            (section as! [Any]).compactMap( { item in
                SettingModel.deserialize(from: item as? [String : Any])
            } )
        } )
        tableView.sectionHeaderHeight = 10
        tableView.cs_registerCell(cell: SettingTableViewCell.self)
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSources.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSources[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cs_dequeueReusableCell() as SettingTableViewCell
        cell.settingModel = dataSources[indexPath.section][indexPath.row]
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.calculateDiskCashSize() //清理缓存
            case 2: cell.selectionStyle = .none  //不点击
            default: break
            }
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        headerView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SettingTableViewCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: cell.clearCacheAlertController()  //清理缓存
            case 4: cell.setupPlayNoticeAlertController() //非 WiFi 网络播放提醒
            default: break
            }
        default:
            break
        }
    }
}
