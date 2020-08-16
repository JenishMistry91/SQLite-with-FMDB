//
//  UpdateViewController.swift
//  SQLite With FMDB
//
//  Created by Jenish Mistry on 15/08/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    // MARK:- Attributes -
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var getRecord: UserDataModel!
    
    // MARK:- Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem?.title = ""
        self.title = "Update Record"
    }
    
    // MARK:- Helper Methods -
    func setData() {
        self.txtFirstName.text = getRecord.fname
        self.txtLastName.text = getRecord.lname
        self.txtEmail.text = getRecord.email
    }
    
    // MARK:- Queries -
    func updateDataWithModel() {
        var model = UserDataModel()
        model.iD = getRecord.iD
        model.fname = self.txtFirstName.text!
        model.lname = self.txtLastName.text!
        model.email = self.txtEmail.text!
        
        if DBManager().getInstance().updateRecordWithModelData(model) {
            print("Record Updated...!!")
            self.navigationController?.popViewController(animated: true)
        } else {
            print("Not Updated")
        }
    }
    
    func updateDataWithQuery() {
        let updateQuery = String(format: "UPDATE User SET fname = '\(self.txtFirstName.text!)', lname = '\(self.txtLastName.text!)', email = '\(self.txtEmail.text!)' WHERE iD = \(getRecord.iD) ")
        if DBManager().getInstance().updateRecordWithQuery(updateQuery) {
            print("Record Updated...!!")
            self.navigationController?.popViewController(animated: true)
        } else {
            print("Not Updated")
        }
    }
    
    
    // MARK:- Button Action -
    @IBAction func btnUpdateTapped(_ sender: Any) {
        updateDataWithQuery()
        
    }
    
}
