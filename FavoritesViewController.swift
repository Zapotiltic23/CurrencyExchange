//
//  FavoritesViewController.swift
//  CurrencyExchange
//
//  Created by lis meza on 4/17/17.
//  Copyright © 2017 Horacio Sanchez. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)

    }
    
    func handleSwipe(_ sender: UISwipeGestureRecognizer){
        
        self.performSegue(withIdentifier: "unwindToRates", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
