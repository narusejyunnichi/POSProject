//
//  ViewController.swift
//  POSProject
//
//  Created by Xin Ge  on 24/11/2017.
//  Copyright © 2017 Xin Ge . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cartViewModel:CartViewModel = CartViewModel(goodsInCart:["ITEM000000","ITEM000000","ITEM000000","ITEM000001","ITEM000003-2"])
        cartViewModel.printReceipt()
    }

}

