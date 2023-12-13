//
//  LTLoginDao.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import Foundation
import WCDBSwift

private let LT_LOVE_LOGIN_TABLE_NAME = "LT_LOVE_LOGIN_TABLE_NAME"

struct LTLoginDao {
    
    static var `default` = LTLoginDao()
    
    func createTable(database: Database) {
        try? database.create(table: LT_LOVE_LOGIN_TABLE_NAME, of: LTLoginModel.self)
    }
    
    func insertList(model: LTLoginModel) async {
        
        guard let database = LTDataBaseTool.default.base else {
            return
        }
        
        do {
            try database.insertOrReplace(objects: [model], intoTable: LT_LOVE_LOGIN_TABLE_NAME)
        } catch  {
            print("\(#function) error : \(error)")
        }
    }
    
    func queryLogin() async -> LTLoginModel? {
        guard let database = LTDataBaseTool.default.base else {
            return nil
        }
        
        let result: [LTLoginModel]? = try? database.getObjects(fromTable: LT_LOVE_LOGIN_TABLE_NAME)
        if let r = result?.first {
            return r
        }
        return nil
    }
    
}
