//
//  LTMyViewController.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import SnapKit

class LTMyViewController: LTBaseViewController {

    var list = [["情侣壁纸","情侣日记","情侣时钟"],["隐私协议","评价我们","关于我们","注销账号","退出登录"]]
    var imageList = [["H-slim","icon_diary","shizhong"],["yinsi","pingjia","guanyu","zhuxiao","jinru"]]

    private lazy var headView: MYHeadView = {
        let headView = MYHeadView()
        return headView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: UIDevice.YH_HomeIndicator_Height, right: 0)
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "LTMyCell", bundle: nil), forCellReuseIdentifier: "cell")
//        tableView.register(TMRegionListCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TMRegionListCell.classForCoder()))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(UIDevice.YH_Fringe_Height + 120)
        }
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.headView.snp_bottom).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-UIDevice.YH_Tabbar_Height)
        }
        
        headView.handleLoginCallback = { [weak self] in
            guard let self = self else {
                return
            }
            let vc = LTLoginViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(login(notifcation:)), name: Notification.Name(rawValue: "LT_LOGIN"), object: nil)
        Task {
            await self.changeData()
        }
    }

    @objc func login(notifcation: Notification) {
        Task {
            await self.changeData()
        }
    }
    
    func changeData() async {
        
        if let model = await LTLoginLogic.share.queryLogin() {
            self.list = [["情侣壁纸","情侣日记","情侣时钟"],["隐私协议","评价我们","关于我们","注销账号","退出登录"]]
            self.headView.getModel(model: model)
            self.headView.isUserInteractionEnabled = false
            self.tableView.reloadData()
            return
        }
        self.list = [["情侣壁纸","情侣日记","情侣时钟"],["隐私协议","评价我们","关于我们"]]
        let model = LTLoginModel()
        model.name = "点击登录"
        model.imageName = ""
        self.headView.getModel(model: model)
        self.headView.isUserInteractionEnabled = true
        self.tableView.reloadData()
    }

}

extension LTMyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LTMyCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.name.text = self.list[indexPath.section][indexPath.row]
        cell.headImageView.image = UIImage(named: self.imageList[indexPath.section][indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = LTLoveTabHeadView(frame: CGRectMake(0, 0, UIDevice.YH_Width, 32))
        if section == 0 {
            v.nameLab.text = "更多功能"
        }else {
            v.nameLab.text = "设置"
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    // MARK: -
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let vc = LTWallpaperViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1 {
                let vc = LTDiaryViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                let vc = LTClockViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return
        }
        
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                let vc = LTYisiViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1 {

            }else {
                let vc = LYAboutViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            return
        }
    }
    
}
