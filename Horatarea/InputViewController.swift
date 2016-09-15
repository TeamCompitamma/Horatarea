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
    
    
    var takeTodoUserDefaults : UserDefaults!
    
    var arraycount : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takeTodoUserDefaults = UserDefaults.standard
        
        if takeTodoUserDefaults.array(forKey: "input") != nil && takeTodoUserDefaults.array(forKey: "date") != nil && takeTodoUserDefaults.array(forKey: "category") != nil{
            inputArray = takeTodoUserDefaults.array(forKey: "input") as! Array<String>
            dateArray = takeTodoUserDefaults.array(forKey: "date") as! Array<String>
            categoryArray = takeTodoUserDefaults.array(forKey: "category") as! Array<String>
            memoArray = takeTodoUserDefaults.array(forKey: "memo") as! Array<String>
            workgaugevalue = takeTodoUserDefaults.array(forKey: "workvalue") as! Array<Int>
            
            arraycount = inputArray.count
            }
        
        self.initView()
        
    }
    
    func initView(){
        
        //やること入力欄の設定
        inputText.delegate = self
        inputText.textColor = UIColor.lightGray
        inputText.text = "やることを入力してください"
        inputText.layer.cornerRadius = 10.0
        inputText.layer.borderWidth = 1.0
        
        //メモ欄の設定
        memoText.delegate = self
        memoText.textColor = UIColor.lightGray
        memoText.text = "メモ(任意)"
        memoText.layer.cornerRadius = 10.0
        memoText.layer.borderWidth = 1.0
        
        
        // 入力欄の設定
        //dateText.text        = dateToString(NSDate())
        self.view.addSubview(dateText)
        
        // UIDatePickerの設定
        myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: #selector(self.changedDateEvent(_:)), for: UIControlEvents.valueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.date
        dateText.inputView = myDatePicker
        
        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.tappedToolBarBtn(_:)))
        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .plain, target: self, action: #selector(self.tappedToolBarBtnToday(_:)))
        
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
        categoryToolBar.barStyle = .blackTranslucent
        categoryToolBar.tintColor = UIColor.white
        categoryToolBar.backgroundColor = UIColor.black
        
        let toolBarBtn2      = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.tappedToolBarBtn(_:)))
        
        toolBarBtn2.tag = 1
        categoryToolBar.items = [toolBarBtn2]
        
        categoryText.inputAccessoryView = categoryToolBar
        
        
        //ボタンの設定
        completeButton.layer.cornerRadius = 10
        completeButton.addTarget(self, action: #selector(self.completeInput(_:)), for: .touchUpInside)

        //進捗度Sliderの設定
        workgauge.addTarget(self, action: #selector(self.changeslider(_:)), for: .valueChanged)
        
    }
    
    
    //完了ボタンをおした時
    func completeInput(_ sender: UIButton){
        
        if inputText.textColor == UIColor.lightGray || inputText.text.isEmpty {
            
            let alert = UIAlertController(title: "何も入力されて無いよ！！",message: "",preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK",style: .default,handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            self.viewDidLoad()
            
        }else{
            //inputArray.append(inputText.text)
            //dateArray.append(dateText.text!)
            //categoryArray.append(categoryText.text!)
            //memoArray.append(memoText.text)
            
            inputArray.insert(inputText.text, at: arraycount)
            dateArray.insert(dateText.text!, at: arraycount)
            categoryArray.insert(categoryText.text!, at: arraycount)
            memoArray.insert(memoText.text, at: arraycount)
            workgaugevalue.insert(Int(workgauge.value), at: arraycount)
            
            takeTodoUserDefaults.set(inputArray, forKey: "input")
            takeTodoUserDefaults.set(dateArray, forKey: "date")
            takeTodoUserDefaults.set(categoryArray, forKey: "category")
            takeTodoUserDefaults.set(memoArray, forKey: "memo")
            takeTodoUserDefaults.set(workgaugevalue, forKey: "workvalue")
            takeTodoUserDefaults.synchronize()
            
            
            performSegue(withIdentifier: "complete", sender: nil)
        }
    }
    
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView!) -> Int {
        return 1
    }
    //カテゴリの数でPickerViewの項目数判定
    func pickerView(_ pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row] as? String;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryText.text = category[row] as? String;
    }
    
    
    func  textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    // 「完了」を押すと閉じる
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        dateText.resignFirstResponder()
        categoryText.resignFirstResponder()
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedToolBarBtnToday(_ sender: UIBarButtonItem) {
        myDatePicker.date = Date()
        changeLabelDate(Date())
    }
    
    //
    func changedDateEvent(_ sender:AnyObject?){
        //var dateSelecter: UIDatePicker = sender as! UIDatePicker
        self.changeLabelDate(myDatePicker.date)
    }
    
    func changeLabelDate(_ date:Date) {
        dateText.text = self.dateToString(date)
    }
    
    func dateToString(_ date:Date) ->String {
        let calender: Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let comps: DateComponents = (calender as NSCalendar).components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day,NSCalendar.Unit.hour,NSCalendar.Unit.minute,NSCalendar.Unit.second,NSCalendar.Unit.weekday], from: date)
        
        let date_formatter: DateFormatter = DateFormatter()
        var weekdays:Array<String>  = ["", "日", "月", "火", "水", "木", "金", "土"]
        
        date_formatter.locale     = Locale(identifier: "ja")
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday!]))"
        
        return date_formatter.string(from: date)
    }
    
    func changeslider(_ sender: UISlider){
        
        let value = Int(workgauge.value)
        
        workgaugetext.text = "進捗度は\(value)%"
        
    }
    
}
