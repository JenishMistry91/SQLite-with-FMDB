//
//  DBManager.swift
//  SQLite With FMDB
//
//  Created by Jenish Mistry on 13/08/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import Foundation

var sharedInstance = DBManager()

class DBManager: NSObject {
    
    // Get instance of the database
    var databse: FMDatabase? = nil
    
    func getInstance() -> DBManager {
        if sharedInstance.databse == nil {
            sharedInstance.databse = FMDatabase(path: DBHandler.getPath("user.db"))
        }
        return sharedInstance
    }
    
    
    // MARK:- Queries -
    
    // Insert Query
    func insertRecordWithModelData(_ modelData: UserDataModel) -> Bool {
        sharedInstance.databse?.open()
        let isRecordSaved = sharedInstance.databse?.executeUpdate("INSERT INTO User (fname, lname, email) VALUES (?,?,?)", withArgumentsIn: [modelData.fname, modelData.lname, modelData.email])
        sharedInstance.databse?.close()
        return isRecordSaved!
    }
    
    func insertRecordWithQuery(_ queryString: String) -> Bool {
        sharedInstance.databse?.open()
        let isRecordSaved = sharedInstance.databse?.executeStatements(queryString)
        sharedInstance.databse?.close()
        return isRecordSaved!
    }
    
    // Retrive Query
    func fetchAllRecord() -> NSMutableArray {
        sharedInstance.databse?.open()
        
        let resultSet:FMResultSet! = (sharedInstance.databse?.executeQuery("SELECT * from User", withArgumentsIn: [0]))
        let dataArray: NSMutableArray = NSMutableArray()
        if resultSet != nil {
            while resultSet.next() {
                var item = UserDataModel()
                item.iD = Int(resultSet.int(forColumn: "iD"))
                item.fname = String(resultSet.string(forColumn: "fname") ?? "")
                item.lname = String(resultSet.string(forColumn: "lname") ?? "")
                item.email = String(resultSet.string(forColumn: "email") ?? "")
                dataArray.add(item)
            }
        }
        
        sharedInstance.databse?.close()
        return dataArray
    }
    
    // Update Query
    func updateRecordWithModelData(_ modelData: UserDataModel) -> Bool {
        sharedInstance.databse?.open()
        let isRecordUpdated = sharedInstance.databse?.executeUpdate("UPDATE User set fname = ?, lname = ?, email = ? WHERE id = ?", withArgumentsIn: [modelData.fname, modelData.lname, modelData.email, modelData.iD])
        sharedInstance.databse?.close()
        return isRecordUpdated!
    }
    
    func updateRecordWithQuery(_ queryString: String) -> Bool {
        sharedInstance.databse?.open()
        let isRecordUpated = sharedInstance.databse?.executeStatements(queryString)
        sharedInstance.databse?.close()
        return isRecordUpated!
    }
    
    // Delete Query
    func deleteRecordWithQuery(_ queryString: String) -> Bool {
        sharedInstance.databse?.open()
        let isRecordDeleted = sharedInstance.databse?.executeStatements(queryString)
        sharedInstance.databse?.close()
        return isRecordDeleted!
    }
}
