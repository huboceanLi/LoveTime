//
//  LTHomeListLogic.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/11/8.
//

import Foundation

@objcMembers public class LTHomeListLogic: NSObject {
    
    static public let share = LTHomeListLogic()
    
    
    func firstSaveData() async {
        
        let infos = await LTHomeListDao.default.queryWithTypeName(typeName: "生活")
        if infos.isEmpty {
            //save
        }
    }

    
}
