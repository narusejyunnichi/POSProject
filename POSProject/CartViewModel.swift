//
//  CartViewModel.swift
//  POSProject
//
//  Created by Xin Ge  on 24/11/2017.
//  Copyright © 2017 Xin Ge . All rights reserved.
//

import UIKit

class CartItemModel {
    var barcode:String = ""
    var name:String = ""
    var unit:String = ""
    var price:Float = 0.0
    var count:Int = 1
    
    init(goodModel: GoodModel) {
        barcode = goodModel.getBarcode()
        name = goodModel.getName()
        unit = goodModel.getUnit()
        price = goodModel.getPrice()
    }
}

public class CartViewModel: NSObject {
    
    private var goodsBarcode: [String]? = nil
    private var goodManager: CartManager = CartManager()
    private var cartItems: [CartItemModel] = Array()
    public var resultString: String = String()
    
    init(goodsInCart: [String]){
        goodsBarcode = goodsInCart
    }
    
    func printReceipt() -> String{
        configCartItems()
        resultString.append(getPrintHeaderString())
        cartItems.forEach { cartItem in
            resultString.append(getPrintCartItem(cartItem: cartItem))
        }
        resultString.append(getPrintLineString())
        resultString.append(getCostString(cost: countCost()))
        resultString.append(getSaveString(save: countSave()))
        resultString.append(getPrintFooterString())
        return resultString
    }
    
    private func configCartItems() {
        guard let goodsBarcode = goodsBarcode else {
            return
        }
        goodsBarcode.forEach { goodBarcode in
            if goodBarcode.contains("-"){
                addCartItmeForUncountable(barcode: goodBarcode)
            }else{
                addCartItmeForCountable(barcode: goodBarcode)
            }
        }
    }
    
    private func addCartItmeForCountable(barcode:String){
        if cartItems.count < 0 {
            addCartItem(barcode: barcode)
        }else{
            if !updateCartItem(barcode: barcode){
                addCartItem(barcode: barcode)
            }
        }
    }
    
    private func addCartItmeForUncountable(barcode:String){
        //这个.map的作用是 将前面的切分好的array里的元素全部初始化成string？
        let array = barcode.split(separator: "-").map(String.init)
        guard let first = array.first, let last = array.last, let goodModel = goodManager.getModel(barcode: first), let count = Int(last) else {
            return
        }
        addCartItem(goodModel: goodModel,count:count)
    }
    
    private func addCartItem(barcode:String){
        guard let goodModel = goodManager.getModel(barcode: barcode) else {
            return
        }
        let item = CartItemModel(goodModel: goodModel)
        cartItems.append(item)
    }
    
    private func addCartItem(goodModel:GoodModel,count:Int){
        let cartItem = CartItemModel(goodModel: goodModel)
        cartItem.count = count
        cartItems.append(cartItem)
    }
    
    private func updateCartItem(barcode:String) -> Bool{
        var exist:Bool = false
        cartItems.forEach({ cartItemModel in
            if cartItemModel.barcode == barcode {
                cartItemModel.count += 1
                exist = true
            }
        })
        return exist
    }
    
    private func getPrintHeaderString() -> String{
        let headerString = "***<没钱赚商店>收据***"
        print(headerString)
        return headerString
    }
    
    private func getPrintCartItem(cartItem:CartItemModel) -> String{
        var cartItemString:String = String()
        cartItemString.append(getNameForPrint(name: cartItem.name))
        cartItemString.append(getCountStringForPrint(count: getCount(barcode: cartItem.barcode, count: cartItem.count), unit: cartItem.unit))
        cartItemString.append(getPriceForPrint(price: cartItem.price))
        cartItemString.append(getSumForPrint(count: cartItem.count, price: cartItem.price))
        print(cartItemString)
        return cartItemString
    }
    
    private func getNameForPrint(name:String) -> String{
        return "名称：\(name)，"
    }
    
    private func getCount(barcode:String,count:Int) ->Int{
        var promotionCount:Int = count
        if checkIsPromotion(barcode: barcode) {
            promotionCount = count + count/2
        }
        return promotionCount
    }
    
    private func getCountStringForPrint(count:Int,unit:String) -> String{
        return "数量：\(count)\(unit)，"
    }
    
    private func checkIsPromotion(barcode:String) -> Bool{
        if goodManager.checkPromotion(barcode: barcode) {
            return true
        }else{
            return false
        }
    }
    
    private func getPriceForPrint(price:Float) -> String{
        return "单价：\(price)(元)，"
    }
    
    private func getSumForPrint(count:Int,price:Float) -> String{
        return "小计：\(Float(count) * price)(元)"
    }
    
    private func getPrintLineString() -> String{
        let printLineString = "----------------------"
        print(printLineString)
        return printLineString
    }
    
    private func getCostString(cost :Float) -> String{
        let costString = "总计：\(cost)(元)"
        print(costString)
        return costString
    }
    
    private func countCost() -> Float{
        var cost:Float = Float()
        cartItems.forEach { cartItem in
            cost += cartItem.price * Float(cartItem.count)
        }
        return cost
    }
    
    private func getSaveString(save :Float) -> String{
        let saveString = "节省：\(save)(元)"
        print(saveString)
        return saveString
    }
    
    private func countSave() -> Float{
        return countSum() - countCost()
    }
    
    private func countSum() -> Float{
        var sum:Float = Float()
        cartItems.forEach { cartItem in
            sum += cartItem.price * Float(getCount(barcode: cartItem.barcode, count: cartItem.count))
        }
        return sum
    }
    
    private func getPrintFooterString() -> String{
        let footerString = "**********************"
        print(footerString)
        return footerString
    }
}
