//
//  BaseTabBarController.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import QMUIKit

class BaseTabBarController: QMUITabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        let vc1 = LTHomeViewController()
        let nav1 = QMUINavigationController(rootViewController: vc1)
        vc1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab_1_off"), selectedImage: UIImage(named: "tab_1_on"))
        vc1.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 60)
        
        
        let vc2 = LTLoveViewController()
        let nav2 = QMUINavigationController(rootViewController: vc2)
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab_2_off"), selectedImage: UIImage(named: "tab_2_on"))
        vc2.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 60)
        
        let vc3 = LTMyViewController()
        let nav3 = QMUINavigationController(rootViewController: vc3)
        vc3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "tab_3_off"), selectedImage: UIImage(named: "tab_3_on"))
        vc3.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 60)
        
        self.viewControllers = [nav1,nav2,nav3]
        
        UITabBar.appearance().tintColor = UIColor.green
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
