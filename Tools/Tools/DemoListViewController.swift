//
//  DemoListViewController.swift
//  UIKitDemo
//
//  Created by apple on 2017/6/28.
//  Copyright © 2017年 lazywe. All rights reserved.
//  列表页。展示不同UI的选择器

import UIKit

enum ListType : String {
    case AttributeString = "属性字符串"
}

class DemoListViewController: DMRootViewController,UITableViewDelegate,UITableViewDataSource{
    
    
    lazy var tableView: UITableView = {
        let tempTableview = UITableView(frame: self.view.frame, style: .plain)
        return tempTableview
    }()
    
    lazy var dataArray: Array = { () -> [ListType] in
        let tempArray = [ListType.AttributeString];
        
        return tempArray;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Tools"
    
        tableView.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        //注册cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    //section数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //每个sections的cell数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    //tableView的cell处理
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row].rawValue
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //点击方法
        tableView.deselectRow(at: indexPath, animated: true)
        let listType = self.dataArray[indexPath.row]
        var vc : UIViewController
        switch listType {
        case .AttributeString:
            vc = TAttributeStringViewController()
       
         //....
        }
        
        vc.title = listType.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
