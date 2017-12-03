//
//  ViewController.swift
//  POSProject
//
//  Created by Xin Ge  on 24/11/2017.
//  Copyright © 2017 Xin Ge . All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var CartReceipt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PosProject"
        // Do any additional setup after loading the view, typically from a nib.
        let cartViewModel:CartViewModel = CartViewModel(goodsInCart:["ITEM000000","ITEM000000","ITEM000000","ITEM000001","ITEM000003-2"])
        CartReceipt.text = cartViewModel.printReceipt()
        showAlertWithBundle()
    }
    
    func showAlertWithBundle() {
        let alert = UIAlertController(title: "输出", message: Bundle.main.bundleIdentifier, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}

