//
//  AddPersonTableViewController.swift
//  私人通讯录
//
//  Created by Administrator on 2017/7/7.
//  Copyright © 2017年 HPerry. All rights reserved.
//

import UIKit

class AddPersonTableViewController: UITableViewController {

    @IBOutlet weak var nametextField: UITextField!
    
    @IBOutlet weak var phonetextField: UITextField!
    
    @IBOutlet weak var bossTextfield: UITextField!
    
    //定义闭包
    typealias saveBlock = () -> ()
    var block:saveBlock?
    
    
    var person:Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if person != nil {
            nametextField.text = person?.name
            phonetextField.text = person?.phone
            bossTextfield.text = person?.title
        }


    }
//保存按钮
    @IBAction func saveButtonEvent(_ sender: Any) {
        
        if person == nil {
            
            person = Person()
        }
        
       //更改数据源
        person?.name = nametextField.text
        person?.phone = phonetextField.text
        person?.title = bossTextfield.text
        
        //设置闭包回调
        block?()
        
        navigationController?.popViewController(animated: true)
    }

}
