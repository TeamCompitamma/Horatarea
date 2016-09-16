//
//  TodoViewController.swift
//  Horatarea
//
//  Created by 松本博希 on 2016/09/13.
//  Copyright © 2016年 Hiroki MATSUMOTO. All rights reserved.
//

import Foundation
import UIKit

class TodoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var myTable : UITableView!
    var getTodoUserdefults : NSUserDefaults!
    var getTodoArray : Array<String> = Array<String>()
    var getdateArray : Array<String> = Array<String>()
    var getcategoryArray : Array<String> = Array<String>()
    var getworkgaugevalue : Array<Int> = Array<Int>()
    
    
    var category2 : NSArray = ["仕事","遊び","勉強"]
    var categoryImage : NSArray = ["workimage.png","playimage.png","studyimage.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTable.dataSource = self
        myTable.delegate = self
        self.view.addSubview(myTable)
        
        getTodoUserdefults = NSUserDefaults.standardUserDefaults()
        
        if getTodoUserdefults.arrayForKey("input") != nil{
            getTodoArray = getTodoUserdefults.arrayForKey("input") as! Array<String>
            getdateArray = getTodoUserdefults.arrayForKey("date") as! Array<String>
            getcategoryArray = getTodoUserdefults.arrayForKey("category") as! Array<String>
            getworkgaugevalue = getTodoUserdefults.arrayForKey("workvalue") as! Array<Int>
        }
    }
    
    //cellの総数を返すメソッド
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTodoArray.count
    }

    //cellにデータを挿入
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Customcell") as! CustomTableViewCell
        
        cell.layer.cornerRadius = 10.0
        cell.layer.borderWidth = 1.0
        
        cell.todolabel.text = getTodoArray[(indexPath as NSIndexPath).row]
        cell.datelabel.text = getdateArray[(indexPath as NSIndexPath).row]
        
        if getcategoryArray[(indexPath as NSIndexPath).row] == category2[0] as! String {
            cell.categoryImage.image = UIImage(named: categoryImage[0] as! String)
        }else if getcategoryArray[(indexPath as NSIndexPath).row] == category2[1] as! String{
            cell.categoryImage.image = UIImage(named: categoryImage[1] as! String)
        }else if getcategoryArray[(indexPath as NSIndexPath).row] == category2[2] as! String{
            cell.categoryImage.image = UIImage(named: categoryImage[2] as! String)
        }else {
            cell.categoryImage.image = UIImage(named: categoryImage[0] as! String)
        }
        
        cell.workvalue.setProgress(Float(getworkgaugevalue[(indexPath as NSIndexPath).row])/100, animated: false)
        
        return cell
    }
    
}
