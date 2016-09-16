//
//  InputViewController.swift
//  Horatarea
//
//  Created by 松本博希 on 2016/09/13.
//  Copyright © 2016年 Hiroki MATSUMOTO. All rights reserved.
//

import Foundation
import UIKit


class InputViewController: UIViewController, UITextViewDelegate, UIToolbarDelegate, UIPickerViewDelegate,UITabBarDelegate{
    
    @IBOutlet var inputText : UITextView!
    @IBOutlet var dateText : UITextField!
    var toolBar:UIToolbar!
    var myDatePicker: UIDatePicker!
    
    @IBOutlet var categoryText : UITextField!
    var myCategoryPicker : UIPickerView!
    var categoryToolBar : UIToolbar!
    var category : NSArray = ["仕事","遊び","勉強"]
    
    @IBOutlet var memoText : UITextView!
    
    @IBOutlet var completeButton : UIButton!
    
    @IBOutlet var workgauge : UISlider!
    @IBOutlet var workgaugetext : UILabel!
    
    var inputArray : Array<String> = Array<String>()
    var dateArray : Array<String> = Array<String>()
    var categoryArray : Array<String> = Array<String>()
    var memoArray : Array<String> = Array<String>()
    var workgaugevalue : Array<Int> = Array<Int>()
    
    
    var takeTodoUserDefaults : NSUserDefaults!
    
    var arraycount : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeTodoUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if takeTodoUserDefaults.arrayForKey("input") != nil && takeTodoUserDefaults.arrayForKey("date") != nil && takeTodoUserDefaults.arrayForKey("category") != nil{
            inputArray = takeTodoUserDefaults.arrayForKey("input") as! Array<String>
            dateArray = takeTodoUserDefaults.arrayForKey("date") as! Array<String>
            categoryArray = takeTodoUserDefaults.arrayForKey("category") as! Array<String>
            memoArray = takeTodoUserDefaults.arrayForKey("memo") as! Array<String>
            workgaugevalue = takeTodoUserDefaults.arrayForKey("workvalue") as! Array<Int>
            
            arraycount = inputArray.count
            }
        
        self.initView()
        
    }
    
    func initView(){
        
        //やること入力欄の設定
        inputText.delegate = self
        inputText.textColor = UIColor.lightGrayColor()
        inputText.text = "やることを入力してください"
        inputText.layer.cornerRadius = 10.0
        inputText.layer.borderWidth = 1.0
        
        //メモ欄の設定
        memoText.delegate = self
        memoText.textColor = UIColor.lightGrayColor()
        memoText.text = "メモ(任意)"
        memoText.layer.cornerRadius = 10.0
        memoText.layer.borderWidth = 1.0
        
        
        // 入力欄の設定
        //dateText.text        = dateToString(NSDate())
        self.view.addSubview(dateText)
        
        // UIDatePickerの設定
        myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: #selector(self.changedDateEvent(_:)), forControlEvents: .ValueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.Date
        dateText.inputView = myDatePicker
        
        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.tappedToolBarBtn(_:)))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.tappedToolBarBtnToday(_:)))
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        
        dateText.inputAccessoryView = toolBar
        
        
        //カテゴリー入力欄の設定
        //categoryText.text = category[0] as? String
        
        self.view.addSubview(categoryText)
        
        //PickerViewの設定
        myCategoryPicker = UIPickerView()
        myCategoryPicker.showsSelectionIndicator = true
        myCategoryPicker.delegate = self
        categoryText.inputView = myCategoryPicker
        
        // UIToolBarの設定
        categoryToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        categoryToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        categoryToolBar.barStyle = .BlackTranslucent
        categoryToolBar.tintColor = UIColor.whiteColor()
        categoryToolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn2      = UIBarButtonItem(title: "完了", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.tappedToolBarBtn(_:)))
        
        toolBarBtn2.tag = 1
        categoryToolBar.items = [toolBarBtn2]
        
        categoryText.inputAccessoryView = categoryToolBar
        
        
        //ボタンの設定
        completeButton.layer.cornerRadius = 10
        completeButton.addTarget(self, action: #selector(self.completeInput(_:)), forControlEvents: .TouchUpInside)

        //進捗度Sliderの設定
        workgauge.addTarget(self, action: #selector(self.changeslider(_:)), forControlEvents: .ValueChanged)
        
    }
    
    
    //完了ボタンをおした時
    func completeInput(sender: UIButton){
        
        if inputText.textColor == UIColor.lightGrayColor() || inputText.text.isEmpty {
            
            let alert = UIAlertController(title: "何も入力されて無いよ！！",message: "",preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK",style: UIAlertActionStyle.Default,handler: nil)
            alert.addAction(okAction)
            presentViewController(alert, animated: true, completion: nil)
            
            self.viewDidLoad()
            
        }else{
            //inputArray.append(inputText.text)
            //dateArray.append(dateText.text!)
            //categoryArray.append(categoryText.text!)
            //memoArray.append(memoText.text)
            
            inputArray.insert(inputText.text, atIndex:arraycount)
            dateArray.insert(dateText.text!, atIndex:  arraycount)
            categoryArray.insert(categoryText.text!, atIndex:  arraycount)
            memoArray.insert(memoText.text, atIndex:  arraycount)
            workgaugevalue.insert(Int(workgauge.value), atIndex:  arraycount)
            
            takeTodoUserDefaults.setObject(inputArray, forKey: "input")
            takeTodoUserDefaults.setObject(dateArray, forKey: "date")
            takeTodoUserDefaults.setObject(categoryArray, forKey: "category")
            takeTodoUserDefaults.setObject(memoArray, forKey: "memo")
            takeTodoUserDefaults.setObject(workgaugevalue, forKey: "workvalue")
            takeTodoUserDefaults.synchronize()
            
            
            performSegueWithIdentifier("complete", sender: nil)
        }
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    //カテゴリの数でPickerViewの項目数判定
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row] as? String;
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryText.text = category[row] as? String;
    }
    
    
    func  textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor(){
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    // 「完了」を押すと閉じる
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        dateText.resignFirstResponder()
        categoryText.resignFirstResponder()
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        myDatePicker.date = NSDate()
        changeLabelDate(NSDate())
    }
    
    //
    func changedDateEvent(sender:AnyObject?){
        //var dateSelecter: UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(myDatePicker.date)
    }
    
    func changeLabelDate(date:NSDate) {
        dateText.text = self.dateToString(date)
    }
    
    func dateToString(date:NSDate) ->String {
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let comps: NSDateComponents = calender.components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Day,NSCalendarUnit.Hour,NSCalendarUnit.Minute,NSCalendarUnit.Second,NSCalendarUnit.Weekday], fromDate: date)
        
        let date_formatter: NSDateFormatter = NSDateFormatter()
        var weekdays: Array  = ["", "日", "月", "火", "水", "木", "金", "土"]
        
        date_formatter.locale     = NSLocale(localeIdentifier: "ja_JP")
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday])） "
        
        return date_formatter.stringFromDate(date)
    }
    
    func changeslider(sender: UISlider){
        
        let value = Int(workgauge.value)
        
        workgaugetext.text = "進捗度は\(value)%"
        
    }
    
}
