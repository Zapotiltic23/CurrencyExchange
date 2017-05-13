//
//  CurrencyModel.swift
//  CurrencyExchange
//
//  Horacio A Sanchez
//  CPSC 411
//  DavidMcLaren
//  May 12 2017
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var flagLabel2: UILabel!
    @IBOutlet weak var currencyLabel1: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    let model = currencyModel.shared
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //This function delegate helps dismiss the keyboard when the user taps 'return' or similar.
        amountTextField.resignFirstResponder()
        
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make Swipe gestures
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft) //Add gesture to the view
        
        //Make Tap Gestures
        //This allows me to tap anywhere on the display to dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        //This adds a fun mistery pokemon to the display
        let pikachu = UIImageView(frame: CGRect(x: CGFloat(160), y: CGFloat(570), width: CGFloat(70), height: CGFloat(70)))
        pikachu.image = UIImage(named: "pokemons.png")
        view.addSubview(pikachu)
        
         //Sets an image as a background on the app view
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        self.view.insertSubview(backgroundImage, at: 0)

        
        
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        amountTextField.delegate = self
        currencyPicker.reloadAllComponents()
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //This function allows me to reload the data in the picker view when i come back to the 1st view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if model.flagText == ""{
            self.flagLabel.text = "💵"
        }else{
            self.flagLabel.text = model.flagText
        }
        
        if model.flagText2 == ""{
            self.flagLabel2.text = "💷"
        }else{
            self.flagLabel2.text = model.flagText2
        }
        
        if model.currency == ""{
            self.currencyLabel1.text = model.currency

        }else{
            self.currencyLabel1.text = model.currency
        }
        
        self.currencyPicker.reloadAllComponents()
        
    }
    //This function notifies the view controller that its view was added to a view hierarchy
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func handleSwipe(_ sender: UISwipeGestureRecognizer){
        
        self.performSegue(withIdentifier: "favorite", sender: self)
    }
    
    // Enable Unwinding other views
    
    @IBAction func unwindToRates(segue: UIStoryboardSegue){
        
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
        return model.favoritesCollection.count
    }
    
    // This function assigns the strings in the 'pickerData' array to the rows of the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return model.favoritesCollection[row]
        
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
        
        let data = model.favoritesCollection[row]
        
        let title = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightRegular)])
        label?.attributedText = title
        label?.textAlignment = .center
        return label!
    }
    
    //MARK: Actions
    
    @IBAction func getRate(_ sender: UIButton) {
        
        if self.amountTextField.text == ""{
            self.amountTextField.text = "1"
        }
        
        
        model.index = model.favoriteIndexes[currencyPicker.selectedRow(inComponent: 0)] // Get the index of selected picker row
        model.index2 = model.favoriteIndexes[currencyPicker.selectedRow(inComponent: 1)]
        //print(model.index)
        //print(model.index2)
        let queryString = "select * from yahoo.finance.xchange where pair in (\"\(model.pickerData[model.index])\",\"\(model.pickerData[model.index2])\")"
        flagLabel.text = model.flags(countryCode: model.countryCode[model.index])
        flagLabel2.text = model.flags(countryCode: model.countryCode[model.index2])
        model.query(queryString){ jsonDict in
            let queryDict = jsonDict["query"] as! NSDictionary
            let results = queryDict["results"] as! NSDictionary
            let rate = results["rate"] as! NSArray
            let index1 = rate[1] as! NSDictionary // rate = [0 1]
            //print(queryDict)
            let currencyRate = index1["Rate"] as! String // This is the exchange rate of the first container idexed [0] in the rate dictionary
            self.currencyLabel1.text = "Exchange Rate: \(currencyRate)"
            self.resultLabel.text = "Conversion = $\(Double(currencyRate)! * Double(self.amountTextField.text!)!)"
            //print(queryString)
        }//End of query
        
        

        
    }//End of getRate
    

}

