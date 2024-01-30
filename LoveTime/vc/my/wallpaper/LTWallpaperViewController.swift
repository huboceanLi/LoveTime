//
//  LTWallpaperViewController.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import UIKit
import SnapKit

class LTWallpaperViewController: LTBaseViewController {

    var list: [String] = []
    var currentIndex = 0
    
    lazy var laout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIDevice.YH_Width, height: UIDevice.YH_Height)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.laout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "LTWallpaperCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton(type: .custom)
        moreButton.setImage(UIImage(named: "baocun"), for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cusNaviBar.hideNaviBar = false
        self.defaultNaviTitleLabel.text = "情侣壁纸"
        self.defaultNaviTitleLabel.textColor = UIColor.white
        self.defaultNaviBackButton.setImage(UIImage(named: "31fanhui1"), for: .normal)
        self.cusNaviBar.rightItems = self.rightItems
        self.cusNaviBar.backgroundColor = UIColor.clear
        self.cusNaviBar.reloadUI(origin: .zero, width: UIDevice.YH_Width)
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.bringSubviewToFront(self.cusNaviBar)
        self.collectionView.contentInsetAdjustmentBehavior = .never

        Task {
            self.list =  await LTDiaryLogic.share.getWallpaperList()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    @objc private func moreAction() {
        print("\(self.currentIndex)")
        
        if let image =  UIImage(named: self.list[self.currentIndex]) {
             // 将图片保存到相册
             UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
         }
    }
    
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let error = error {
            // 保存失败
            print("Image save error: \(error.localizedDescription)")
            MYToast.onlyShowTextHUD("保存失败!")
        } else {
            // 保存成功
            MYToast.onlyShowTextHUD("保存成功!")
        }
    }
}

extension LTWallpaperViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(LTWallpaperCell.classForCoder()), for: indexPath) as? LTWallpaperCell else { return UICollectionViewCell() }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LTWallpaperCell

        
        cell.headImageView.image = UIImage(named: self.list[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = self.collectionView.contentOffset.y
        self.currentIndex = Int(y / UIDevice.YH_Height)
    }
}

