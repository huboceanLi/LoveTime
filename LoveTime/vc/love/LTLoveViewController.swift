//
//  LTLoveViewController.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import SnapKit
import MBProgressHUD

let loveListItemWidth = ceil((UIDevice.YH_Width - 15 * 5) / 4) - 1
let loveListItemHeight = ceil((UIDevice.YH_Width - 15 * 5) / 4) - 1 + 8 + 32

class LTLoveViewController: LTBaseViewController {

    lazy var loveHeadView: LTLoveHeadView = {
        let loveHeadView = LTLoveHeadView(frame: .zero)
        return loveHeadView
    }()
    
    var lsatMap: [String: [LTLoveListModel]] = [:]

    lazy var laout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSize(width: loveListItemWidth, height: loveListItemHeight)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIDevice.YH_Width, height: 40)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.laout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LTLoveListCell.classForCoder(), forCellWithReuseIdentifier: NSStringFromClass(LTLoveListCell.classForCoder()))
        collectionView.register(LTLoveListHeadView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeUI()
        getData()
    }
    
    func initializeUI() {
        self.view.addSubview(self.loveHeadView)
        self.loveHeadView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottom).offset(-UIDevice.YH_Tabbar_Height)
            make.top.equalTo(self.loveHeadView.snp_bottom).offset(0)
        }
    }
    
    func getData() {
        Task {
            await LTLoveListLogic.share.firstSaveData()
            self.lsatMap = await LTLoveListLogic.share.queryAll()
            self.collectionView.reloadData()
        }
    }
}

extension LTLoveViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            if let arr = lsatMap["爱的初体验"] {
                return arr.count
            }
        }
        if section == 1 {
            if let arr = lsatMap["享受慢时光"] {
                return arr.count
            }
        }
        if section == 2 {
            if let arr = lsatMap["挑战不可能"] {
                return arr.count
            }
        }
        if section == 3 {
            if let arr = lsatMap["爱的高光时刻"] {
                return arr.count
            }
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(LTLoveListCell.classForCoder()), for: indexPath) as? LTLoveListCell else { return UICollectionViewCell() }

        cell.backgroundColor = UIColor.purple
        var list: [LTLoveListModel] = []
        if indexPath.section == 0 {
            if let arr = lsatMap["爱的初体验"] {
                list = arr
            }
        }else if indexPath.section == 1 {
            if let arr = lsatMap["享受慢时光"] {
                list = arr
            }
        }else if indexPath.section == 2 {
            if let arr = lsatMap["挑战不可能"] {
                list = arr
            }
        }else {
            if let arr = lsatMap["爱的高光时刻"] {
                list = arr
            }
        }
        cell.getModel(model: list[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension LTLoveViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! LTLoveListHeadView

        if indexPath.section == 0 {
            header.desLab.text = "爱的初体验"
        }else if indexPath.section == 1 {
            header.desLab.text = "享受慢时光"
        }else if indexPath.section == 2 {
            header.desLab.text = "挑战不可能"
        }else {
            header.desLab.text = "爱的高光时刻"
        }
//        header.showTitle(index: indexPath.section, dic: self.dataDic)
        
        return header
    }
    
}
