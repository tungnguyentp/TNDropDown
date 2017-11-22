//
//  ViewController.swift
//  TNDropDown
//
//  Created by Tung Nguyen on 11/22/17.
//  Copyright © 2017 Tung Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dropDown: TNDropDown!

    override func viewDidLoad() {
        super.viewDidLoad()

        dropDown.dataSource = ["123","234","345","456","345","456"]
        dropDown.lableTitle.text = dropDown.dataSource[2]
        dropDown.delegateTNDropDown = self
 
    }
}

extension ViewController: TNDropDwonDeletgate{
    func didSelectRow(row: Int) {
        UIView.animate(withDuration: 0.45) {
            self.dropDown.lableTitle.text = self.dropDown.dataSource[row]
        }
    }
}

