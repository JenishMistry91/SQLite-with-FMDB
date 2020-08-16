//
//  DBHandler.swift
//  SQLite With FMDB
//
//  Created by Jenish Mistry on 13/08/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import Foundation

class DBHandler: NSObject {
        
    class func getPath(_ filename: String) -> String {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = documentDirectory.appendingPathComponent(filename)
        print(fileUrl.path)
        return fileUrl.path
    }
    
    class func copyDatabase(_ filename: String) {
        let dbPath = getPath("user.db")
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: dbPath) {
            let bundle = Bundle.main.resourceURL
            let file =  bundle?.appendingPathComponent(filename)
            var error: NSError?
            do {
                try fileManager.copyItem(atPath: (file?.path)!, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            if error == nil {
                print("Error in DB")
            } else {
                print("DB Success...!!")
            }
        }
    }
}
