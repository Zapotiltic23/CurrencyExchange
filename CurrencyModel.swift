//
//  CurrencyModel.swift
//  CurrencyExchange
//
//  Created by lis meza on 4/15/17.
//  Copyright © 2017 Horacio Sanchez. All rights reserved.
//

import Foundation

class currencyModel {
    
     let pickerData = ["AFN", "EUR", "ALL", "USD", "EUR", "AOA", "XCD", "XCD", "XCD", "ARS", "ARS", "AWG", "EUR", "AZN", "BSD", "BHD", "BDT", "BBD", "BYN", "EUR", "BZD", "BMD", "BTN", "BOB", "BAM", "BWP", "BRL", "BND", "BGN", "XOF", "XAF", "CAD", "EUR", "CVE", "KYD", "XAF", "CLP", "CNY", "COP", "CRC", "XOF", "HRK", "CUP", "EUR", "DKK", "DOP", "USD", "EGP", "USD", "EUR", "ETB", "EUR", "EUR", "EUR", "GHS", "EUR", "DKK", "GTQ", "GNF", "HTG", "HNL", "HUF", "ISK", "INR", "IDR", "IRR", "IQD", "EUR", "ILS", "EUR", "JMD", "JPY", "JOD", "KZT", "KES", "LBP", "LRD", "LYD", "EUR", "EUR", "MKD", "MGA", "MYR", "MXN", "MNT", "EUR", "MAD", "MZN", "NPR", "EUR", "NZD", "NIO", "NGN", "KPW", "NOK", "PKR", "PAB", "PYG", "PEN", "PHP", "PLN", "EUR", "USD", "QAR", "RON", "RUB", "RWF", "WST", "EUR", "SAR", "XOF", "RSD",  "SLL", "SGD", "EUR", "EUR", "SOS", "ZAR", "KRW", "EUR", "LKR", "SDG", "SEK", "CHF", "SYP", "TWD", "TJS", "TZS", "THB", "XOF", "TTD", "TND", "TRY", "USD", "UGX", "UAH", "AED", "GBP", "USD", "UYU", "UZS", "EUR", "VEF", "VND", "YER", "ZMW", "USD"]
    
    
    
     let pickerCountry = ["Afghanistan", "Åland Islands", "Albania", "American Samoa", "Andorra", "Angola", "Anguilla", "Antigua & Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas" ,"Bahrain" ,"Bangladesh" ,"Barbados" ,"Belarus" ,"Belgium", "Belize" ,"Bermuda" ,"Bhutan", "Bolivia" ,"Bosnia & Herzegovina" , "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Cameroon", "Canada", "Canary Islands", "Cape Verde", "Cayman Islands", "Chad", "Chile", "China", "Colombia", "Costa Rica", "Côte d’Ivoire", "Croatia", "Cuba", "Cyprus", "Denmark", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Estonia", "Ethiopia", "Finland", "France", "Germany", "Ghana", "Greece", "Greenland", "Guatemala", "Guinea", "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Lebanon", "Liberia", "Libya", "Lithuania", "Luxembourg", "Macedonia", "Madagascar", "Malaysia", "Mexico", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Nepal", "Netherlands", "New Zealand", "Nicaragua", "Nigeria", "North Korea", "Norway", "Pakistan", "Panama", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Puerto Rico", "Qatar", "Romania", "Russia", "Rwanda", "Samoa", "San Marino", "Saudi Arabia", "Senegal", "Serbia", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Somalia", "South Africa", "South Korea", "Spain", "Sri Lanka", "Sudan", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan", "Tanzania", "Thailand", "Togo", "Trinidad & Tobago", "Tunisia", "Turkey", "Turks & Caicos Islands", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vatican City", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"]
    
     let countryCode = ["AF", "AX", "AL", "AS", "AD", "AO", "AI", "AG", "AR", "AM", "AW", "AU", "AT", "AZ", "BS", "BH", "BD", "BB", "BY", "BE", "BZ", "BM", "BT", "BO", "BA", "BW", "BR", "BN", "BG", "BF", "CM", "CA", "IC", "CV", "KY", "TD", "CL", "CN", "CO", "CR", "CI", "HR", "CU", "CY", "DK", "DO", "EC", "EG", "SV", "EE", "ET", "FI", "FR", "DE", "GH", "GR", "GL", "GU", "GN", "HT", "HN", "HU", "IS", "IN", "ID", "IR", "IQ", "IE", "IL", "IT", "JM", "JP", "JO", "KZ", "KE", "LB", "LR", "LY", "LT", "LU", "MK", "MG", "MY", "MX", "MN", "ME", "MA", "MZ", "NP", "NL", "NZ", "NI", "NG", "KP", "NO", "PK", "PA", "PY", "PE", "PH", "PL", "PT", "PR", "QA", "RO", "RU", "RW", "WS", "SM", "SA", "SN", "RS", "SL", "SG", "SK", "SI", "SO", "ZA", "KR", "ES", "LK", "SD,", "SE", "CH", "SY", "TW", "TJ", "TZ", "TH", "TG", "TT", "TN", "TR", "TC", "UG", "UA", "AE", "GB", "US", "UY", "UZ", "VA", "VE", "VN", "YE", "ZM", "ZW"]
    
    var favoritesCollection:[String] = []
    
    var index: Int
    var index2: Int
    var favoritesIndexPicker: Int
    var manager: Int
    var checkIndex: IndexPath
    var checkIndex2: IndexPath
    
    init(_ index: Int, _ index2: Int, _ favoritesIndexPicker: Int, _ manager: Int, _ checkIndex: IndexPath, _ checkIndex2: IndexPath){
        
        self.index = index
        self.index2 = index2
        self.favoritesIndexPicker = favoritesIndexPicker
        self.manager = manager
        self.checkIndex = [0,0]
        self.checkIndex2 = [0,0]
    }//End of constructor
    
    static let shared:currencyModel = currencyModel(0,0,0,0,[0,0],[0,0])
    
    func flags(countryCode: String) -> String{
        
        let base = 127397
        var usv = String.UnicodeScalarView()
        for c in countryCode.utf16{
            
            usv.append(UnicodeScalar(base + Int(c))!)
        }//End of loop
        return String(usv)
    }//End of flags
    
    func query(_ statement:String, completion: @escaping ([String: Any]) -> Void) {
        
        let QUERY_PREFIX = "https://query.yahooapis.com/v1/public/yql?q="
        let QUERY_SUFFIX = "&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback="
        let url = URL(string: "\(QUERY_PREFIX)\(statement.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)\(QUERY_SUFFIX)")
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let dataDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject!
                    let results:[String: AnyObject] = dataDict! as! [String : AnyObject]
                    completion(results)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}//End of currencyModel class








