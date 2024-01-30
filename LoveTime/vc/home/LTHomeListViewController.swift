//
//  LTHomeListViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/27.
//

import UIKit
import SnapKit
import MBProgressHUD

let homeListItemWidth = ceil((UIDevice.YH_Width - 15 * 4) / 3) - 1
let homeListItemHeight = ceil((UIDevice.YH_Width - 15 * 4) / 3) - 1 + 8 + 32

class LTHomeListViewController: LTBaseViewController {

    var listMap: [String: [LTHomeListModel]] = [:]
    var keyList: [String] = []

    lazy var laout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSize(width: homeListItemWidth, height: homeListItemHeight)
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: UIDevice.YH_Width, height: 40)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.laout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "LTHomeListCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(LTHomeListHeadView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.clear
        
//        let welcomeMessage = NSLocalizedString("生活", comment: "test456")

        
        initializeUI()

        Task {
            let _ = await LTHomeListLogic.share.firstSaveData()
            
            self.listMap = await LTHomeListLogic.share.queryHomeListAll()
            self.keyList = Array(self.listMap.keys)
            self.collectionView.reloadData()

//            if let str: String = UserDefaults.standard.object(forKey: "TITLENAME") as? String, str.count > 0 {
//                self.defaultNaviTitleLabel.text = str
//                self.list = await LTHomeListLogic.share.queryWithTypeName(typeName: str)
//                self.collectionView.reloadData()
//            }else {
//                UserDefaults.standard.setValue("生活", forKey: "TITLENAME")
//                self.defaultNaviTitleLabel.text = "生活"
//                self.list = await LTHomeListLogic.share.queryWithTypeName(typeName: "生活")
//                self.collectionView.reloadData()
//            }
            
        }
    }
    
    func initializeUI() {
        
        self.defaultNaviTitleLabel.text = "恋爱卡片册"
        self.cusNaviBar.hideNaviBar = false
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.defaultNaviBackButton.isHidden = true
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)

        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottom).offset(-UIDevice.YH_Tabbar_Height)
            make.top.equalTo(self.cusNaviBar.snp_bottom).offset(0)
        }
    }

}

extension LTHomeListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.keyList.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let l = self.listMap[self.keyList[section]] {
            return l.count
        }

        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LTHomeListCell else { return UICollectionViewCell() }

        cell.backgroundColor = UIColor.clear

        let n = self.keyList[indexPath.section]
        
        
        if let l = self.listMap[n] {
            cell.getModel(model: l[indexPath.row])
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = HomeEditViewController()
        let n = self.keyList[indexPath.section]
        if let l = self.listMap[n] {
            vc.model = l[indexPath.row]
        }
        
        self.present(vc, animated: true)
        
        vc.handleChangeModelCallback = { [weak self] in
            
            guard let self = self else { return }
            
            Task {
                self.listMap = await LTHomeListLogic.share.queryHomeListAll()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }

    }
}

extension LTHomeListViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! LTHomeListHeadView

        header.titleLab.text = self.keyList[indexPath.section]
        return header
    }
    
}
