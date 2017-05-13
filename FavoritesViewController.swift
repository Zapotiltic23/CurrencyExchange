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

class FavoritesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    // [MARK]: Properties & Share
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var favoritesPickerView: UIPickerView!
    @IBOutlet weak var favoriteOutlet: UIButton!
//    @IBOutlet weak var exchangeOutlet: UIButton!
    
    
    let model = currencyModel.shared
    
    //---------------------------------------------------------------------------------------------
    //[MARK]: View set up

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        
        
        favoritesPickerView.dataSource = self
        favoritesPickerView.delegate = self
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        //exchangeOutlet.isEnabled = false
        
    }//End of viewDidLoad()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //---------------------------------------------------------------------------------------------
    // [MARK]: Actions
    
//    @IBAction func exchangeButton(_ sender: UIButton) {
// 
//        let queryString = "select * from yahoo.finance.xchange where pair in (\"\(model.pickerData[model.checkIndex[1]])\",\"\(model.pickerData[model.checkIndex[1]])\")"
//        
//        model.flagText = model.flags(countryCode: model.favoritesCountryCode[model.indexArray[0]])
//        model.flagText2 = model.flags(countryCode: model.favoritesCountryCode[model.indexArray[1]])
//        print(print(model.favoritesCountryCode))
//        print(model.favoritesCountryCode[model.indexArray[0]])
//        print(model.favoritesCountryCode[model.indexArray[1]])
//
//        model.query(queryString){ jsonDict in
//            let queryDict = jsonDict["query"] as! NSDictionary
//            let results = queryDict["results"] as! NSDictionary
//            let rate = results["rate"] as! NSArray
//            let index1 = rate[1] as! NSDictionary // rate = [0 1]
//            let currencyRate = index1["Rate"] as! String // This is the exchange rate of the first container idexed [0] in the rate dictionary
//            self.model.currency = currencyRate
//            print(results)
//        }//End of query
//        
//        //* Need to uncheck the selected rows before going back to the 1st view so we can check mark again
//        //  when we come back to this second view. Manager counter has to be reset as well.
//        
//        //* We need to empty the 'model.idexArray' variable so that we can perform accurate checks on the 2nd view
//        
//        model.indexArray = []
//        model.manager = 0
//        favoritesTableView.cellForRow(at: model.checkIndex)?.accessoryType = UITableViewCellAccessoryType.none
//        favoritesTableView.cellForRow(at: model.checkIndex2)?.accessoryType = UITableViewCellAccessoryType.none
//        self.performSegue(withIdentifier: "unwindToRates", sender: self)
//    }//End of exchangeButton()
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        // Use 'UserDefaults' to store user's favorites, indexes & country codes into our respective arrays
        
        //model.favoriteIndexes.removeo
        model.favoritesCollection.append(model.pickerCountry[favoritesPickerView.selectedRow(inComponent: 0)])
        UserDefaults.standard.set(model.favoritesCollection, forKey: "favorites")
        
        model.favoriteIndexes.append(favoritesPickerView.selectedRow(inComponent: 0))
        UserDefaults.standard.set(model.favoriteIndexes, forKey: "favoriteIndexes")
        
        model.favoritesCountryCode.append(model.countryCode[favoritesPickerView.selectedRow(inComponent: 0)])
        UserDefaults.standard.set(model.favoritesCountryCode, forKey: "favoriteCountryCode")
        
        model.favoriteCountryData.append(model.pickerData[favoritesPickerView.selectedRow(inComponent: 0)])
        UserDefaults.standard.set(model.favoriteCountryData, forKey: "favoriteCountryData")

        print(model.favoritesCountryCode)
        favoritesTableView.reloadData()

        
    }//End of favoriteButton()
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let savedFavorites = UserDefaults.standard.object(forKey: "favorites") as? [String]{

            model.favoritesCollection = savedFavorites
        }
    }//End of viewDidAppear()
    
    
    //---------------------------------------------------------------------------------------------
    
    //[MARK]: Class methods
    
    func handleSwipe(_ sender: UISwipeGestureRecognizer){
        
        //Need to uncheck the selected rows before going back to the 1st view so we can check mark again
        //when we come back to this second view. Manager counter has to be reset as well.
        model.manager = 0
        favoritesTableView.cellForRow(at: model.checkIndex)?.accessoryType = UITableViewCellAccessoryType.none
        favoritesTableView.cellForRow(at: model.checkIndex2)?.accessoryType = UITableViewCellAccessoryType.none
        self.performSegue(withIdentifier: "unwindToRates", sender: self)
        
    }//End of handleSwipe
    //---------------------------------------------------------------------------------------------

    //[MARK]: PickerView protocol functions
    
    // The functions 'numberOfComponents' & 'pickerView' define one components (columns) with the number of rows = to the number of items in the array 'pickerData'
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.pickerData.count
    }
    
    // This function assigns the strings in the 'pickerData' array to the rows of the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return model.pickerCountry[row]
    }
    
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
    //---------------------------------------------------------------------------------------------
    
    //[MARK]: TableView protocol functions

    //This function defines the nuber of rows for our table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.favoritesCollection.count
    }
    
    //This function contains 'indexPath' which is the index at a given row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        //Set name to each table cell
        cell.textLabel?.text = model.favoritesCollection[indexPath.row]
        return cell
    }
    
    
    //This function allows me to delete a given rown in my table view
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            //**Need to delete the correct value at the correct index from the favoriteIndexes array**
            // User 'UserDefaults' to store the newly modified favorites array (deleting a row)
            model.favoritesCollection.remove(at: indexPath.row)
            model.favoriteIndexes.remove(at: indexPath.row)
            model.favoritesCountryCode.remove(at: indexPath.row)
            model.favoriteCountryData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(model.favoritesCollection, forKey: "favorites")
            UserDefaults.standard.set(model.favoriteIndexes, forKey: "favoriteIndexes")
            UserDefaults.standard.set(model.favoritesCountryCode, forKey: "favoriteCountryCode")
            UserDefaults.standard.set(model.favoriteCountryData, forKey: "favoriteCountryData")
        }
    }
    
    
//    //This function allows me to place/remove a checkmark on a highlighted row of the table view
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        
//        
//        // Only let user select favorites up to 2
//        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none {
//            
//            
////            if model.manager != 2{
////                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
////                model.checkIndex = indexPath
//            
//                model.indexArray.append(indexPath.row)
//                //model.favoriteCountryData.append(indexPath.row)
//                print(model.indexArray)
//                
//                model.manager += 1
//                if model.manager == 2{
//                    exchangeOutlet.isEnabled = true
//                }
//                //print(model.manager)
//            }
//            if model.manager == 1{
//                favoriteOutlet.isEnabled = false
//            }
//            
//        }
//        // Always let the user unselect favorites
//        else if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
//            
//            for index in model.indexArray{
//                if indexPath.row == index{
//                    model.indexArray.remove(at: model.indexArray.index(of: index)!)
//                
//                }
//            }
//            print(model.indexArray)
//            //model.indexArray.remove(at: indexPath.row)
//            
//            model.manager -= 1
//            if model.manager == 0{
//                favoriteOutlet.isEnabled = true
//            }
//            if model.manager != 2{
//                exchangeOutlet.isEnabled = false
//            }
//            model.checkIndex2 = indexPath
//            //print(model.checkIndex2[1])
//        }
    
//}//End of tableview
    //---------------------------------------------------------------------------------------------
    
}//End of FavoritesViewController

