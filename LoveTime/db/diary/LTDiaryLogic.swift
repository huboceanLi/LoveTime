//
//  LTDiaryLogic.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/14.
//

import Foundation


@objcMembers public class LTDiaryLogic: NSObject {
    
    static public let share = LTDiaryLogic()
    
    func insertList(name: String, content: String) async {
        
        let model = LTDiaryModel()
        model.content = content
        model.name = name
        model.create_Time = LTHomeListLogic.share.getNowTime()
        
        await LTDiaryDao.default.insertList(model: model)
    }
    
    func queryAll() async -> [LTDiaryModel] {
        
        return await LTDiaryDao.default.queryAll()
    }
}
