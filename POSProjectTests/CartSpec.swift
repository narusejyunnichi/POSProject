//
//  CartSpec.swift
//  POSProjectTests
//
//  Created by Xin Ge  on 24/11/2017.
//  Copyright © 2017 Xin Ge . All rights reserved.
//

import Quick
import Nimble
@testable import POSProject

class CartSpec: QuickSpec {
    override func spec() {
        describe("print result") {
            it("expect output", closure: {
                let cartViewModel:CartViewModel = CartViewModel(goodsInCart: ["ITEM000000","ITEM000000","ITEM000000","ITEM000001","ITEM000003-2"])
                cartViewModel.printReceipt()
                expect(cartViewModel.resultString).to(equal("***<没钱赚商店>收据***名称：可口可乐，数量：4瓶，单价：3.0(元)，小计：9.0(元)名称：羽毛球，数量：1个，单价：1.0(元)，小计：1.0(元)名称：苹果，数量：3斤，单价：5.5(元)，小计：11.0(元)----------------------总计：21.0(元)节省：8.5(元)**********************"))
            })
        }
    }
}
