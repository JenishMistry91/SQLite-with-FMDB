//
//  InsertViewController.swift
//  SQLite With FMDB
//
//  Created by Jenish Mistry on 13/08/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController {
    
    // MARK:- attributes -
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    // MARK:- Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem?.title = ""
        self.title = "Insert Record"
    }
    
    // MARK:- Button action method-
    @IBAction func btnSaveTapped(_ sender: Any) {
        insertRecordWithModelData()
    }
    
    // MARK:- Queries -
    func insertRecordWithModelData() {
        var model = UserDataModel()
        model.fname = self.txtFirstName.text!
        model.lname = self.txtLastName.text!
        model.email = self.txtEmail.text!
        
        if DBManager().getInstance().insertRecordWithModelData(model) {
            print("Saved record in DB...!!")
            self.navigationController?.popViewController(animated: true)
        } else {
            print("Not saved record")
        }
    }
    
    func insertRecordWithQuery() {
        
        let queryString = String(format: "INSERT INTO User (fname, lname, email) VALUES ('%@','%@','%@')", txtFirstName.text!, txtLastName.text!, txtEmail.text!)
        if DBManager().getInstance().insertRecordWithQuery(queryString) {
            print("Saved record in DB...!!")
        } else {
            print("Not saved record")
        }
    }
    
}
