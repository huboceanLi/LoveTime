//
//  LTDiaryDao.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/14.
//

import Foundation
import WCDBSwift

private let LT_LOVE_DIARY_TABLE_NAME = "LT_LOVE_DIARY_TABLE_NAME"

struct LTDiaryDao {
    
    static var `default` = LTDiaryDao()
    
    func createTable(database: Database) {
        try? database.create(table: LT_LOVE_DIARY_TABLE_NAME, of: LTDiaryModel.self)
    }
    
    func insertList(model: LTDiaryModel) async {
        
        guard let database = LTDataBaseTool.default.base else {
            return
        }
        
        do {
            try database.insertOrReplace(objects: [model], intoTable: LT_LOVE_DIARY_TABLE_NAME)
        } catch  {
            print("\(#function) error : \(error)")
        }
    }
    
    func queryAll() async -> [LTDiaryModel] {
        guard let database = LTDataBaseTool.default.base else {
            return []
        }
        
        let result: [LTDiaryModel]? = try? database.getObjects(fromTable: LT_LOVE_DIARY_TABLE_NAME)
        if let r = result {
            return r
        }
        return []
    }
    
}
