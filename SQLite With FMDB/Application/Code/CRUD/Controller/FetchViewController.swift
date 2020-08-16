//
//  FetchViewController.swift
//  SQLite With FMDB
//
//  Created by Jenish Mistry on 14/08/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import UIKit

class FetchViewController: UIViewController {

    // MARK:- Attributes -
    @IBOutlet weak var tblView: UITableView!
    var modelData = [UserDataModel]()
    
    // MARK:- Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func viewWillAppear(_ animated: Bool) {
        retriveData()
        self.navigationItem.backBarButtonItem?.title = ""
        self.title = "Fetch Record"
    }
    
    // MARK:- Helper Methods -
    func initView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK:- Queries -
    func retriveData() {
        let array = DBManager().getInstance().fetchAllRecord()
        self.modelData = array.map( { $0 as! UserDataModel } )
        self.tblView.reloadData()
    }
    
    func deleteDataWithQuery(_ deleteWithID: Int) -> Bool {
        let deleteQuery = String(format: "DELETE from User WHERE iD = \(deleteWithID) ")
        if DBManager().getInstance().updateRecordWithQuery(deleteQuery) {
            print("Record Deleted...!!")
            return true
        }
        return false
    }

}

// MARK:- UITableView Delegate Methods -
extension FetchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = modelData[indexPath.row].fname + " || " + modelData[indexPath.row].lname + " || " + modelData[indexPath.row].email
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        controller.getRecord = self.modelData[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if deleteDataWithQuery(self.modelData[indexPath.row].iD) {
                self.modelData.remove(at: indexPath.row)
                tblView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
