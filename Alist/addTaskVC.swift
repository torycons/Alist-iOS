//
//  addTaskVC.swift
//  Alist
//
//  Created by Thanapat Sorralump on 1/7/17.
//  Copyright © 2017 Thanapat Sorralump. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class addTaskVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  
  @IBOutlet weak var topicImage: UIImageView!
  @IBOutlet weak var detailText: UITextView!
  @IBOutlet weak var topicTextView: UITextField!
  @IBOutlet weak var detailTextView: UITextField!
  @IBOutlet weak var typeBtn: UITextField!
  @IBOutlet weak var dateBtn: UITextField!
  @IBOutlet weak var importantBtn: UISwitch!
  @IBOutlet weak var saveBtn: UIButton!
  
  
  let thonburiFont = UIFont(name: "Thonburi", size: 17)
  let typeArr : [String] = ["Personal", "Work", "Hobby", "Other"]
  let typePickerView = UIPickerView()
  let user = Auth.auth().currentUser
  
  var ref: DatabaseReference! = Database.database().reference()
  
  override func viewWillAppear(_ animated: Bool) {
    // set font for navigationBar
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: thonburiFont!, NSAttributedStringKey.foregroundColor: UIColor.white]
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //edit navigation bar
    self.title = "เพิ่มการแจ้งเตือนใหม่"
    self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    
    // edit Border textView
    self.topicTextView.borderStyle = UITextBorderStyle.roundedRect
    self.detailTextView.borderStyle = UITextBorderStyle.roundedRect
    
    // type pickerView
    typePickerView.delegate = self
    typePickerView.dataSource = self
    typeBtn.inputView = typePickerView
    
    // dismiss keyboard by tap on view
    let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTaskVC.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
    // for observe keyboard show or hide
    NotificationCenter.default.addObserver(self, selector: #selector(addTaskVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(addTaskVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    //delegate for close keyboard by press return button
    topicTextView.delegate = self
    detailTextView.delegate = self
    
    //corner radius for saveBtn
    saveBtn.layer.cornerRadius = 8
  }
  
  
  // return button for close keyboard
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
  }
  
  
  // pickerview component
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return typeArr.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return typeArr[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    typeBtn.text = typeArr[row]
  }
  
  //dismiss keyboard function
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
  
  //keyboard show or hide
  @objc func keyboardWillShow(_ notification: NSNotification){
    self.view.frame.origin.y = -75
    
  }
  @objc func keyboardWillHide(_ notification: NSNotification){
    self.view.frame.origin.y = 63
  }
  
  //date picker function
  @objc func datePickerValue(sender:UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateBtn.text = dateFormatter.string(from: sender.date)
  }
  
  @IBAction func datePicker(_ sender: Any) {
    let datePicker: UIDatePicker = UIDatePicker()
    datePicker.datePickerMode = UIDatePickerMode.date
    dateBtn.inputView = datePicker
    datePicker.addTarget(self, action: #selector(addTaskVC.datePickerValue(sender:)), for: UIControlEvents.valueChanged)
  }
  
  @IBAction func saveList(_ sender: Any) {
    
    if topicTextView.text! == "" || detailTextView.text! == "" || typeBtn.text! == "กดเพื่อเลือกหัวข้อ" || dateBtn.text! == "กดเพื่อเลือกวันที่" {
      
      // alert if don't insert every text field
      let alert = UIAlertController(title: "ใส่ข้อมูลไม่ครบ", message: "กรุณาใส่ข้อมูลให้ครบทุกช่องเพื่อดำเนินการต่อ", preferredStyle: UIAlertControllerStyle.alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
      self.present(alert, animated: true, completion: nil)
      
    } else {
      // save to Firebase
      let listForUpdate = [
        "listTopic": topicTextView.text!,
        "listDetail": detailTextView.text!,
        "listType": typeBtn.text!,
        "listDate": dateBtn.text!,
        "listImportant": Bool(importantBtn.isOn)
        ] as [String : Any]
      
      self.ref.child("user").child((user?.uid)!).childByAutoId().setValue(listForUpdate)
      
      guard ((navigationController?.popViewController(animated: true)) != nil) else {
        print("No nevigation Controller")
        return
      }
    }
  }
}
