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
    
    func getWallpaperList() async -> [String] {
        
        var l: [String] = []
        for i in 0..<35 {
            
            let s = "b" + String(i + 1)
            l.append(s)
        }
        
        return self.shuffleArray(l)
    }
    
    func shuffleArray<T>(_ array: [T]) -> [T] {
        var shuffledArray = array
        let count = shuffledArray.count

        for i in 0..<count {
            let randomIndex = Int.random(in: i..<count)
            if i != randomIndex {
                shuffledArray.swapAt(i, randomIndex)
            }
        }

        return shuffledArray
    }
}

