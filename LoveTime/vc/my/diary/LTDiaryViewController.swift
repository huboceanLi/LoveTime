//
//  LTDiaryViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit

class LTDiaryViewController: LTBaseViewController {

    var list: [LTDiaryModel] = []
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.setImage(UIImage(named: "chat_list_more"), for: .normal)
        moreButton.addTarget(self, action: #selector(moreAction), for: .touchUpInside)
        return moreButton
    }()
    
    private lazy var rightItems: [Any] = {
        var rightSpaceItem = YHCusNavigationSpaceItem()
        rightSpaceItem.space = 10.0
        
        var rightAddItem = YHCusNavigationBarItem()
        rightAddItem.width = 40.0
        rightAddItem.view = self.moreButton
        
        return [rightAddItem, rightSpaceItem]
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: UIDevice.YH_HomeIndicator_Height, right: 0)
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "LTDiaryListCell", bundle: nil), forCellReuseIdentifier: "cell")
//        tableView.register(TMRegionListCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(TMRegionListCell.classForCoder()))
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "情侣日记"
        self.cusNaviBar.rightItems = self.rightItems
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(0)
        }
        Task {
            self.list = await LTDiaryLogic.share.queryAll()
            self.tableView.reloadData()
        }
    }
    
    @objc private func moreAction() {
        let vc = LTDiaryAddViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.handleDiaryCallback = { [weak self] in
            guard let self = self else {
                return
            }
            Task {
                self.list = await LTDiaryLogic.share.queryAll()
                self.tableView.reloadData()
            }
        }
    }

}

extension LTDiaryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LTDiaryListCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.name.text = self.list[indexPath.row].name
        cell.content.text = self.list[indexPath.row].content
        cell.timeLab.text = LTHomeListLogic.share.convertTimestampToDateTime(timestamp: TimeInterval(self.list[indexPath.row].create_Time/1000))
        
        return cell
    }

    // MARK: -
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = LTDiaryPrewViewController()
        vc.model = self.list[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
