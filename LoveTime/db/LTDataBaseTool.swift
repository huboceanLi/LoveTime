//
//  LTDataBaseTool.swift
//  LoveTime
//
//  Created by Ocean 李 on 2023/10/16.
//

import UIKit
import WCDBSwift

let USER_DATABASE_FLODER_NAME = "Database"

class LTDataBaseTool : NSObject {
    
    static var `default` = LTDataBaseTool()
    
    private static let QUERY_LIMIT = 900
    
    var base: Database?
    
    func getDB() -> Database? {
        return base
    }
    
    func initDB(userID: String) {
        
        guard let dbBase = self.getDatabase(userId: userID) else {
            return
        }
        self.base = dbBase
        LTHomeListDao.default.createTable(database: dbBase)
//        HYUkSearchKeyDao.default.createTable(database: dbBase)
//        HYUkHistoryRecordDao.default.createTable(database: dbBase)
//        HYUkDownListDao.default.createTable(database: dbBase)
//        HYUKNoticeListDao.default.createTable(database: dbBase)
    }
    
    // MARK: -
    private func getDatabasePath() -> String? {
        
        let path = HYLocalPathManager.funVideoRootPath("DB")
        let createDbPath = HYLocalPathManager.createPath(path)

        if createDbPath {
            print("Database Folder Path: \(path)")
            return path
        }
        return nil
    }
    
    /// Get a database with userID,  one user one database
    func getDatabase(userId: String) -> Database? {
        if let dbPath = self.getDatabasePath() {
            let userDBPath = dbPath + "/" + userId + ".db"
            let database = Database(withPath: userDBPath)
            return database
        }
        return nil
    }
    
}
