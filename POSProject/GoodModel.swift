//
//  GoodModel.swift
//  POSProject
//
//  Created by Xin Ge  on 24/11/2017.
//  Copyright © 2017 Xin Ge . All rights reserved.
//

import UIKit

class GoodModel {
    private var barcode : String = ""
    private var name : String = ""
    private var unit : String = ""
    private var price : Float = 0.0
    
    public init(param:Dictionary<String, Any>){
        configModel(param: param)
    }
    
    func configModel(param:Dictionary<String, Any>){
        barcode = param["barcode"] as! String
        name = param["name"] as! String
        unit = param["unit"] as! String
        price = param["price"] as! Float
    }
    
    func getBarcode() -> String {
        return barcode
    }
    
    func getName() -> String {
        return name
    }
    
    func getUnit() -> String {
        return unit
    }
    
    func getPrice() -> Float {
        return price
    }
}
