//
//  LTLoginLogic.swift
//  LoveTime
//
//  Created by oceanMAC on 2023/12/13.
//

import Foundation

@objcMembers public class LTLoginLogic: NSObject {
    
    static public let share = LTLoginLogic()
    
    func insertList(phone: String, pwd: String) async {
        let model = LTLoginModel()
        
        let randomNumber = arc4random_uniform(100) + 1
        model.imageName = String(randomNumber)
        model.phone = phone
        model.name = self.generateRandomString(length: 16)
        model.pwd = pwd
        await LTLoginDao.default.insertList(model: model)
    }
    
    func queryLogin() async -> LTLoginModel? {
        
        let result = await LTLoginDao.default.queryLogin()
        
        return result
    }
    
    func generateRandomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let charactersCount = UInt32(characters.count)

        var randomString = ""

        for _ in 0..<length {
            let randomIndex = Int(arc4random_uniform(charactersCount))
            let randomChar = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            randomString.append(randomChar)
        }

        return randomString
    }
}
