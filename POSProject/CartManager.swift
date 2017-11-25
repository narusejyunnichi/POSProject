//
//  CartManager.swift
//  POSProject
//
//  Created by Xin Ge  on 24/11/2017.
//  Copyright © 2017 Xin Ge . All rights reserved.
//

import UIKit

class CartManager: NSObject {
    private var goods : Array<GoodModel> = Array()
    private var promotionGoodsBarcode :Array<String> = Array()
    
    override init() {
        super.init()
        getGoodData()
        getPromotionData()
    }
    
    func getGoodData(){
        let path = Bundle.main.path(forResource: "goods", ofType: "plist")
        guard let goodsDataPath = path else {
            return
        }
        let data = NSArray(contentsOfFile:goodsDataPath)
        guard let goodsData = data else {
            return
        }
        configModel(goodDictionaries: goodsData as! Array<Dictionary<String, Any>>)
    }
    
    func configModel(goodDictionaries:Array<Dictionary<String,Any>>){
        for good:Dictionary in goodDictionaries {
            let model:GoodModel = GoodModel(param: good)
            goods.append(model)
        }
    }
    
    func getPromotionData(){
        promotionGoodsBarcode.append("ITEM000000")
        promotionGoodsBarcode.append("ITEM000001")
//        promotionGoodsBarcode.append("ITEM000002")
        promotionGoodsBarcode.append("ITEM000003")
//        promotionGoodsBarcode.append("ITEM000004")
    }
    
    func getModel(barcode:String) -> GoodModel?{
        for good:GoodModel in goods {
            if barcode == good.getBarcode(){
                return good
            }
        }
        return nil
    }
    
    func checkPromotion(barcode:String) -> Bool{
        for promotionBarcode in promotionGoodsBarcode{
            if barcode == promotionBarcode {
                return true
            }
        }
        return false
    }
}
