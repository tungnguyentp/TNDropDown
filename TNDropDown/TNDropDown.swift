//
//  TNDropDown.swift
//  TNDropDown
//
//  Created by Tung Nguyen on 11/22/17.
//  Copyright © 2017 Tung Nguyen. All rights reserved.
//

import UIKit

protocol TNDropDwonDeletgate {
    func didSelectRow(row: Int)
}

class TNDropDown: UIView {
    //ádahjdsa
    // MARK: Var
    var delegateTNDropDown: TNDropDwonDeletgate?

    var dataSource:[String] = []
    
    var tableViewDropDown = UITableView()

    var isCheck:Bool = true
    
    var heightTableView: CGFloat!
    
    var heightRow:CGFloat = 44

    var lableTitle: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.font = UIFont(name: "", size: 18)
        return lable
    }()
    
    // MARK: Proty IBInspectable
    @IBInspectable
    var bgView: UIColor {
        set{
            self.bgView1 = newValue
        }
        get{
            return self.bgView1
        }
    }
    fileprivate var bgView1:UIColor = UIColor.white
    
    @IBInspectable
    var corner: CGFloat {
        set{
            self.corner1 = newValue
        }
        get{
            return self.corner1
        }
    }
    fileprivate var corner1:CGFloat = 10
    
    @IBInspectable
    var border: CGFloat {
        set{
            self.border1 = newValue
        }
        get{
            return self.border1
        }
    }
    fileprivate var border1:CGFloat = 1
    
    @IBInspectable
    var borderColor: CGColor {
        set{
            self.borderColor1 = newValue
        }
        get{
            return self.borderColor1
        }
    }
    fileprivate var borderColor1:CGColor = UIColor.darkGray.cgColor
    
    
    // MARK: Setup Layout
    override func layoutSubviews() {
        super.layoutSubviews()

        tableViewDropDown.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableViewDropDown.dataSource = self
        tableViewDropDown.delegate = self
        tableViewDropDown.layer.cornerRadius = corner
        tableViewDropDown.layer.borderWidth = 1
        tableViewDropDown.layer.borderColor = borderColor

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
        self.addGestureRecognizer(tap)
        
        self.layer.masksToBounds = false
        self.backgroundColor = bgView
        self.layer.cornerRadius = corner
        self.layer.borderColor = borderColor
        self.layer.borderWidth = border
        
        lableTitle.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(lableTitle)
        
        
        heightTableView = dataSource.count > 5 ? heightRow * 5 : heightRow * (CGFloat(dataSource.count))
        
        
    }
    
    // MARK: Function
    
    @objc func tapView(){
        lableTitle.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: {
            self.lableTitle.alpha = 0.0
        }) { (true) in
            self.lableTitle.alpha = 1.0
            self.showAndHideView()
        }
    }
    
    func showAndHideView(){
        if self.isCheck == true{
            self.animationShow()
        }else{
            self.animationHide()
        }
        self.isCheck = !self.isCheck
    }
    
    func animationShow(){
        
        tableViewDropDown.alpha = 0
        self.tableViewDropDown.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + 5, width: self.frame.width, height: 0)
        UIView.animate(withDuration: 0.25) {
            self.tableViewDropDown.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + 5, width: self.frame.width, height: self.heightTableView)
            self.tableViewDropDown.alpha = 1
             self.superview?.addSubview(self.tableViewDropDown)
        }
    }
    
    func animationHide(){
        self.tableViewDropDown.alpha = 1
         self.tableViewDropDown.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + 5, width: self.frame.width, height: self.heightTableView)
        UIView.animate(withDuration: 0.25, animations: {
            self.tableViewDropDown.alpha = 0
            self.tableViewDropDown.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + 5, width: self.frame.width, height: 0)
        }) { (true) in
            self.tableViewDropDown.removeFromSuperview()
        }
    }
}

// MARK: Extension
extension TNDropDown: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegateTNDropDown?.didSelectRow(row: indexPath.row)
        animationHide()
        isCheck = !isCheck
    }
}
