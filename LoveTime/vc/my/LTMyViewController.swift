//
//  LTMyViewController.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import SnapKit

class LTMyViewController: LTBaseViewController {

    private lazy var headView: MYHeadView = {
        let headView = MYHeadView()
        return headView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
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
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottom).offset(-UIDevice.YH_Tabbar_Height)
        }
        headView.frame = CGRectMake(0, 0, UIDevice.YH_Width, 100)
        self.tableView.tableHeaderView = self.headView
    }


}

extension LTMyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LTMyCell
        cell.selectionStyle = .none
        
       
        return cell
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
        
    }
    
}
