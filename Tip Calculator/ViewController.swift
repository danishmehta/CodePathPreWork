//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Danish Mehta on 07/03/17.
//  Copyright © 2017 Danish Mehta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    var amount:Double = 0;
    var tip:Double = 1.15;
    var people:Int = 1;
    var total:Double = 0;
    
    var tipOptions:[String] = [String]()
    var peopleOptions:[String] = [String]()

    @IBOutlet weak var amountInput: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var finalAmount: UILabel!
    @IBOutlet weak var tipPicker: UIPickerView!
    @IBOutlet weak var noOfPeople: UIPickerView!
    
    @IBAction func numberInput(_ sender: UIButton) {
        if(sender.tag>=1&&sender.tag<=10){
            amountInput.text = amountInput.text! + String(sender.tag%10)
            amount = Double(amountInput.text!)!
        } else if (sender.tag==11){
            if(!amountInput.text!.contains(".")){
                amountInput.text = amountInput.text! + "."
                amount = Double(amountInput.text!)!
            }
        } else if (sender.tag==12 && !(amountInput.text?.isEmpty)!) {
            var amt:String = amountInput.text!
            let index = amt.index(amt.endIndex, offsetBy: -1)
            amt = amt.substring(to: index)
            amountInput.text = amt
            if(!((amountInput.text?.isEmpty)!)){
                amount = Double(amountInput.text!)!
            }
        }
        
        if(!(amountInput.text?.isEmpty)!){
            total = amount * tip;
            totalAmount.text = "\(total)"
            var fa = total/Double(people);
            fa = Double(round(fa*100)/100)
            finalAmount.text = "\(fa)"
        } else {
            totalAmount.text = ""
            finalAmount.text = ""
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipOptions = ["15%", "18%", "20%"]
        peopleOptions = ["1", "2", "3", "4", "5", "6"]
        
        self.tipPicker.dataSource = self
        self.noOfPeople.dataSource = self
        self.tipPicker.delegate = self
        self.noOfPeople.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == self.noOfPeople){
            return peopleOptions.count
        } else if (pickerView == self.tipPicker){
            return tipOptions.count
        }
        return 0
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?  {
        if(pickerView == self.noOfPeople){
            return peopleOptions[row]
        } else if (pickerView == self.tipPicker){
            return tipOptions[row]
        }
        return peopleOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == self.noOfPeople){
            people = row+1
        } else if (pickerView == self.tipPicker){
            switch row {
            case 0:
                tip = 1.15
            case 1:
                tip = 1.18
            case 2:
                tip = 1.20
            default:
                tip = 1.15
            }
        }
        
        if(!(amountInput.text?.isEmpty)!){
            total = amount * tip;
            totalAmount.text = "\(total)"
            var fa = total/Double(people);
            fa = Double(round(fa*100)/100)
            finalAmount.text = "\(fa)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData:String="";
        if(pickerView==tipPicker){
            titleData = tipOptions[row]
        } else if(pickerView==noOfPeople){
            titleData = peopleOptions[row]
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }


}

