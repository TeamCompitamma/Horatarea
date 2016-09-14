//
//  InputViewController.swift
//  Horatarea
//
//  Created by 松本博希 on 2016/09/13.
//  Copyright © 2016年 Hiroki MATSUMOTO. All rights reserved.
//

import Foundation
import UIKit

class InputViewController: UIViewController, UITextViewDelegate, UIToolbarDelegate{
    
    @IBOutlet var inputText : UITextView!
    @IBOutlet var dateText : UITextField!
    var toolBar:UIToolbar!
    var myDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
        inputText.textColor = UIColor.lightGrayColor()
        inputText.text = "やることを入力してください"
        inputText.layer.cornerRadius = 10.0
        inputText.layer.borderWidth = 1.0
        
        // 入力欄の設定
        //textField = UITextField(frame: CGRectMake(self.view.frame.size.width/3, 100, 0, 0))
        dateText.placeholder = dateToString(NSDate())
        dateText.text        = dateToString(NSDate())
        //textField.sizeToFit()
        self.view.addSubview(dateText)
        
        // UIDatePickerの設定
        myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: #selector(self.changedDateEvent(_:)), forControlEvents: UIControlEvents.ValueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.Date
        dateText.inputView = myDatePicker
        
        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .Plain, target: self, action: #selector(self.tappedToolBarBtn(_:)))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .Plain, target: self, action: #selector(self.tappedToolBarBtnToday(_:)))
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        
        dateText.inputAccessoryView = toolBar
        
        
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
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        myDatePicker.date = NSDate()
        changeLabelDate(NSDate())
    }
    
    //
    func changedDateEvent(sender:AnyObject?){
        var dateSelecter: UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(myDatePicker.date)
    }
    
    func changeLabelDate(date:NSDate) {
        dateText.text = self.dateToString(date)
    }
    
    func dateToString(date:NSDate) ->String {
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let comps: NSDateComponents = calender.components([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Day,NSCalendarUnit.Hour,NSCalendarUnit.Minute,NSCalendarUnit.Second,NSCalendarUnit.Weekday], fromDate: date)
        
        let date_formatter: NSDateFormatter = NSDateFormatter()
        var weekdays:Array<String>  = ["", "日", "月", "火", "水", "木", "金", "土"]
        
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday]))"
        
        return date_formatter.stringFromDate(date)
    }
    
}