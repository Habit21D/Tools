//
//  TAttributeStringViewController.swift
//  Tools
//
//  Created by apple on 2017/8/4.
//  Copyright © 2017年 jyn. All rights reserved.
//

import UIKit

class TAttributeStringViewController: DMRootViewController {

    lazy var label : UILabel = {
        var label = UILabel(frame: CGRect(x: 20, y: 100, width: ScreenWidth - 40, height: 100))
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(label)
        
        setLabelAttribute()
    }
    
    func setLabelAttribute() {

        label.attributedText = TAttributeString().setString(string: "swift：这里只是封装了最常用的功能，采用简单的链式调用，核心方法很少，都是一些方便调用的衍生方法", color: UIColor.black, fontSize: 14).highlight(string: "swift：", color: UIColor.red, fontSize: 20).highlight (string: "链式调用", color: UIColor.blue, font: UIFont.boldSystemFont(ofSize: 10)).attributeStr
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
