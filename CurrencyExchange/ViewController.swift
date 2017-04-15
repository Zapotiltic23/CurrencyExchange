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
    @IBOutlet weak var curencyLabel2: UILabel! //Dont' try to change the identifier for these variables!
    
    private let pickerData = ["AFN", "EUR", "ALL", "USD", "EUR", "AOA", "XCD", "XCD", "XCD", "ARS", "ARS", "AWG", "EUR", "AZN", "BSD", "BHD", "BDT", "BBD", "BYN", "EUR", "BZD", "BMD", "BTN", "BOB", "BAM", "BWP", "BRL", "BND", "BGN", "XOF", "XAF", "CAD", "EUR", "CVE", "KYD", "XAF", "CLP", "CNY", "COP", "CRC", "XOF", "HRK", "CUP", "EUR", "DKK", "DOP", "USD", "EGP", "USD", "EUR", "ETB", "EUR", "EUR", "EUR", "GHS", "EUR", "DKK", "GTQ", "GNF", "HTG", "HNL", "HUF", "ISK", "INR", "IDR", "IRR", "IQD", "EUR", "ILS", "EUR", "JMD", "JPY", "JOD", "KZT", "KES", "LBP", "LRD", "LYD", "EUR", "EUR", "MKD", "MGA", "MYR", "MXN", "MNT", "EUR", "MAD", "MZN", "NPR", "EUR", "NZD", "NIO", "NGN", "KPW", "NOK", "PKR", "PAB", "PYG", "PEN", "PHP", "PLN", "EUR", "USD", "QAR", "RON", "RUB", "RWF", "WST", "EUR", "SAR", "XOF", "RSD",  "SLL", "SGD", "EUR", "EUR", "SOS", "ZAR", "KRW", "EUR", "LKR", "SDG", "SEK", "CHF", "SYP", "TWD", "TJS", "TZS", "THB", "XOF", "TTD", "TND", "TRY", "USD", "UGX", "UAH", "AED", "GBP", "USD", "UYU", "UZS", "EUR", "VEF", "VND", "YER", "ZMW", "USD"]
    
    
    
    private let pickerCountry = ["Afghanistan", "Åland Islands", "Albania", "American Samoa", "Andorra", "Angola", "Anguilla", "Antigua & Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas" ,"Bahrain" ,"Bangladesh" ,"Barbados" ,"Belarus" ,"Belgium", "Belize" ,"Bermuda" ,"Bhutan", "Bolivia" ,"Bosnia & Herzegovina" , "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Cameroon", "Canada", "Canary Islands", "Cape Verde", "Cayman Islands", "Chad", "Chile", "China", "Colombia", "Costa Rica", "Côte d’Ivoire", "Croatia", "Cuba", "Cyprus", "Denmark", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Ethiopia", "Finland", "France", "Germany", "Ghana", "Greece", "Greenland", "Guatemala", "Guinea", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Lebanon", "Liberia", "Libya", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malaysia", "Mexico", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Nigeria", "North Korea", "Norway", "Pakistan", "Panama", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Romania", "Russia", "Rwanda", "Samoa", "San Marino", "Saudi Arabia", "Senegal", "Serbia", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Somalia", "South Africa", "South Korea", "Spain", "Sri Lanka", "Sudan", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Trinidad & Tobago", "Tunisia", "Turkey", "Turks & Caicos Islands", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"]
    
    private let countryCode = ["AF", "AX", "AL", "AS", "AD", "AO", "AI", "AG", "AR", "AM", "AW", "AU", "AT", "AZ", "BS", "BH", "BD", "BB", "BY", "BE", "BZ", "BM", "BT", "BO", "BA", "BW", "BR", "BN", "BG", "BF", "CM", "CA", "IC", "CV", "KY", "TD", "CL", "CN", "CO", "CR", "CI", "HR", "CU", "CY", "DK", "DO", "EC", "EG", "SV", "EE", "ET", "FI", "FR", "DE", "GH", "GR", "GL", "GU", "GN", "HT", "HN", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IL", "IT", "JM", "JP", "JO", "KZ", "KE", "LB", "LR", "LY", "LT", "LU", "MK", "MG", "MY", "MX", "MN", "ME", "MA", "MZ", "NP", "NL", "NZ", "NI", "NG", "KP", "NO", "PK", "PA", "PY", "PE", "PH", "PL", "PT", "PR", "QA", "RO", "RU", "RW", "WS", "SM", "SA", "SN", "RS", "SL", "SG", "SK", "SI", "SO", "ZA", "KR", "ES", "LK", "SD,", "SE", "CH", "SY", "TW", "TJ", "TZ", "TH", "TG", "TT", "TN", "TR", "TC", "UG", "UA", "AE", "GB", "US", "UY", "UZ", "VA", "VE", "VN", "YE", "ZM", "ZW"]
    
    
    
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
        return pickerData.count
    }
    
    // This function assigns the strings in the 'pickerData' array to the rows of the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerCountry[row]
    }
    
    //This function changes the font size and color of the text in the picker
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let sizeData =  pickerCountry[row]
        let countries = NSAttributedString(string: sizeData, attributes: [NSFontAttributeName:UIFont(name: "Thonburi", size: 20.0)!, NSForegroundColorAttributeName:UIColor.black])
        
        return countries
    }
    
    func flags(countryCode: String) -> String{
        
        let base = 127397
        var usv = String.UnicodeScalarView()
        for c in countryCode.utf16{
            
            usv.append(UnicodeScalar(base + Int(c))!)
        }
        return String(usv)
        
    }
    
    //MARK: Actions
    
    @IBAction func getRate(_ sender: UIButton) {
        
        let index = currencyPicker.selectedRow(inComponent: 0) // Get the index of selected picker row
        let index2 = currencyPicker.selectedRow(inComponent: 1)
        currencyLabel1.text = pickerData[index] // Set label to selected picker row
        curencyLabel2.text = pickerData[index2]
        flagLabel.text = flags(countryCode: countryCode[index])
        flagLabel2.text = flags(countryCode: countryCode[index2])
        
        
    }
    

}

