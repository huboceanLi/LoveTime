//
//  LTBaseViewController.swift


import UIKit
import SnapKit

@objcMembers public class LTBaseViewController: UIViewController {

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = true
            }
        }
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.bringSubviewToFront(self.cusNaviBar)
    }
    /// The default back button in the navigation bar
    public lazy var defaultNaviBackButton: UIButton = {
        let defaultNaviBackButton = UIButton(type: .custom)
        defaultNaviBackButton.setImage(UIImage.init(named: "bc_navi_black_back"), for: .normal)
        defaultNaviBackButton.titleLabel?.adjustsFontSizeToFitWidth = true
        defaultNaviBackButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return defaultNaviBackButton
    }()

    private var appStatusBarStyle: UIStatusBarStyle = .default

    public lazy var defaultNaviTitleLabel: UILabel = {
        let defaultNaviTitleLabel = UILabel()
        defaultNaviTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        defaultNaviTitleLabel.adjustsFontSizeToFitWidth = true
        defaultNaviTitleLabel.textAlignment = .center
        defaultNaviTitleLabel.adjustsFontSizeToFitWidth = true
        defaultNaviTitleLabel.numberOfLines = 2
        defaultNaviTitleLabel.minimumScaleFactor = 12
        return defaultNaviTitleLabel
    }()
    
    private lazy var defaultNaviLeftItems: [Any] = {
        let spaceItem = YHCusNavigationSpaceItem()
        spaceItem.space = 0.0
        
        let backItem = YHCusNavigationBarItem()
        backItem.view = self.defaultNaviBackButton
        backItem.width = 44.0
        
        return [spaceItem, backItem]
    }()
    
    public lazy var cusNaviBar: LTCusNavigationBar = {
        let cusNaviBar = LTCusNavigationBar()
        cusNaviBar.hideNaviBar = true // By default, the entire navigation bar is hidden to avoid bugs: if set to true, the navigation bar will flash when entering an interface that needs to hide the navigation bar
        cusNaviBar.hideBar = false
        cusNaviBar.hideToolBar = true
        cusNaviBar.hideStatusBar = false
        cusNaviBar.leftItems = self.defaultNaviLeftItems
        cusNaviBar.titleView = self.defaultNaviTitleLabel
        return cusNaviBar
    }()
    
    public lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView(frame: .zero)
        bgImageView.image = UIImage.init(named: "bg")
//        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.updateStatusBarStyle(isLight: false)
        self.view.addSubview(cusNaviBar)
        
        self.view.addSubview(bgImageView)

        bgImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
//            make.height.equalTo(UIDevice.YH_Width)
        }
    }
    
    public func updateStatusBarStyle(isLight: Bool) {
        if #available(iOS 13.0, *) {
            if !isLight {
                self.appStatusBarStyle = .darkContent
            } else {
                self.appStatusBarStyle = .lightContent
            }
        } else {
            if !isLight {
                self.appStatusBarStyle = .default
            } else {
                self.appStatusBarStyle = .lightContent
            }
        }
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override public var prefersStatusBarHidden: Bool {
        return false
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle{
        /*
        let infoDic = Bundle.main.infoDictionary
        if let infoDic = infoDic, let style = infoDic["UIStatusBarStyle"] as? String, style == "UIStatusBarStyleLightContent" {
            return .lightContent
        }
        return .default
        */
        return self.appStatusBarStyle
    }
    
    @objc private func backButtonAction() {
        if let navi = self.navigationController {
            if navi.viewControllers.count > 1 {
                
                LTDefine.pop(withSender: navi, destination: "")
            } else {
                if let _ = navi.presentingViewController {
                    LTDefine.dismissWhithDestination(navi)
                } else {
                    LTDefine.pop(withSender: navi, destination: "")
                }
            }
        } else if let _ = self.presentingViewController {
            LTDefine.dismissWhithDestination(self)
        } else {
            if let nav = self.navigationController {
                LTDefine.pop(withSender: nav, destination: "")
            }
        }
    }
    
    deinit {
        print("\(self.classForCoder) deinit !!")
    }

}
