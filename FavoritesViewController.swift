//
//  FavoritesViewController.swift
//  CurrencyExchange
//
//  Created by lis meza on 4/17/17.
//  Copyright © 2017 Horacio Sanchez. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    // [MARK]: Properties & Share
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var favoritesPickerView: UIPickerView!
    @IBOutlet weak var favoriteOutlet: UIButton!
    @IBOutlet weak var exchangeOutlet: UIButton!
    
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
        
        exchangeOutlet.isEnabled = false
        
        
        
    }//End of viewDidLoad()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //---------------------------------------------------------------------------------------------
    
    // [MARK]: Actions
    
    @IBAction func exchangeButton(_ sender: UIButton) {
 
        //Need to uncheck the selected rows before going back to the 1st view so we can check mark again
        //when we come back to this second view. Manager counter has to be reset as well.
        model.manager = 0
        favoritesTableView.cellForRow(at: model.checkIndex)?.accessoryType = UITableViewCellAccessoryType.none
        favoritesTableView.cellForRow(at: model.checkIndex2)?.accessoryType = UITableViewCellAccessoryType.none
        self.performSegue(withIdentifier: "unwindToRates", sender: self)

        
    }
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        // Use 'UserDefaults' to store user's favorites into our favorites collection array
        model.favoritesCollection.append(model.pickerCountry[favoritesPickerView.selectedRow(inComponent: 0)])
        UserDefaults.standard.set(model.favoritesCollection, forKey: "favorites")
        favoritesTableView.reloadData()
        
        
        //print(model.favoritesCollection)
        
    }//End of favoriteButton
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let savedFavorites = UserDefaults.standard.object(forKey: "favorites") as? [String]{

            model.favoritesCollection = savedFavorites
        }
    }
    
    
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
            
            // User 'UserDefaults' to store the newly modified favorites array (deleting a row)
            model.favoritesCollection.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(model.favoritesCollection, forKey: "favorites")
        }
    }
    
    
    //This function allows me to place/remove a checkmark on a highlighted row of the table view
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        
        // Only let user select favorites up to 2
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.none {
            
            
            if model.manager != 2{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                model.checkIndex = indexPath
                //print(indexPath)
                //print(model.checkIndex)
                
                model.manager += 1
                if model.manager == 2{
                    exchangeOutlet.isEnabled = true
                }
                print(model.manager)
            }
            if model.manager == 1{
                favoriteOutlet.isEnabled = false
            }
            
        }
        // Always let the user unselect favorites
        else if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            model.manager -= 1
            if model.manager == 0{
                favoriteOutlet.isEnabled = true
            }
            if model.manager != 2{
                exchangeOutlet.isEnabled = false
            }
            model.checkIndex2 = indexPath
            //print(indexPath)
            //print(model.checkIndex2)
            print(model.manager)
        }
        
    }//End of tableview
    //---------------------------------------------------------------------------------------------
    
}//End of FavoritesViewController

