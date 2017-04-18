//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by lis meza on 4/11/17.
//  Copyright © 2017 Horacio Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var flagLabel2: UILabel!
    @IBOutlet weak var currencyLabel1: UILabel!
    
    
    let model = currencyModel.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The functions 'numberOfComponents' & 'pickerView' define two components (columns) with the number of rows = to the number of items in the array 'pickerData'
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.pickerData.count
    }
    
    // This function assigns the strings in the 'pickerData' array to the rows of the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return model.pickerCountry[row]
    }
    
    
    //func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
     //   let sizeData =  model.pickerCountry[row]
        
     //   let countries = NSAttributedString(string: sizeData, attributes: [NSFontAttributeName:UIFont(name: "Thonburi", size: 20.0)!, NSForegroundColorAttributeName:UIColor.black])
        
  //      return countries
//    }
    
    //This function changes the font size of the text in the picker
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        let data = model.pickerCountry[row]
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!
    }
    
    //MARK: Actions
    
    @IBAction func getRate(_ sender: UIButton) {
        
        
        model.index = currencyPicker.selectedRow(inComponent: 0) // Get the index of selected picker row
        model.index2 = currencyPicker.selectedRow(inComponent: 1)
        let queryString = "select * from yahoo.finance.xchange where pair in (\"\(model.pickerData[model.index])\",\"\(model.pickerData[model.index2])\")"
        flagLabel.text = model.flags(countryCode: model.countryCode[model.index])
        flagLabel2.text = model.flags(countryCode: model.countryCode[model.index2])
        model.query(queryString){ jsonDict in
            let queryDict = jsonDict["query"] as! NSDictionary
            let results = queryDict["results"] as! NSDictionary
            let rate = results["rate"] as! NSArray
            let index1 = rate[1] as! NSDictionary // rate = [0 1]
            let currencyRate = index1["Rate"] as! String // This is the exchange rate of the first container idexed [0] in the rate dictionary
            self.currencyLabel1.text = "Exchange rate: \(currencyRate)"
            print(queryString)
        }//End of query

        
    }//End of getRate
    

}

