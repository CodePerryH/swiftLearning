//
//  ListTableViewController.swift
//  私人通讯录
//
//  Created by Administrator on 2017/7/7.
//  Copyright © 2017年 HPerry. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    var dataSource = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postData { (data) in
            self.dataSource += data
            
            self.tableView.reloadData()
        }
    }

    private func postData(success:@escaping ([Person]) -> ()){
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1.0)
            var array = [Person]()
            
            for i in 0..<20{
                
                let person = Person()
                
                person.name = "perru_\(i)"
                person.phone = "1890" + String(format: "%06d", arc4random_uniform(100000))
                person.title = "boss"
                
                array.append(person)
            }
            
            DispatchQueue.main.async(execute:{
                success(array)
            })
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].name
        cell.detailTextLabel?.text = dataSource[indexPath.row].phone
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //跳转
        performSegue(withIdentifier: "goident", sender: indexPath)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as!AddPersonTableViewController
        
        if let index = sender as? IndexPath {
            
            vc.person = dataSource[index.row]
            
            //回调
            vc.block = {
                //刷新指定行
                self.tableView.reloadRows(at: [index], with: .automatic)
            }
        }else{
            //添加新的
            
            guard let p = vc.person  else { return  }
            
            self.dataSource.insert(p, at: 0)
            
            self.tableView.reloadData()
            
            
        }
        
    }
}
