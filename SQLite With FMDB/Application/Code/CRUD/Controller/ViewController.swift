//
//  ViewController.swift
//  SQLite With FMDB
//
//  Created by Jenish Mistry on 13/08/20.
//  Copyright © 2020 Jenish Mistry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Button action method -
    @IBAction func btnInsertTapped(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "InsertViewController") as! InsertViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func btnFetchRecordTapped(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "FetchViewController") as! FetchViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

