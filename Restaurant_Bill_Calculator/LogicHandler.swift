//
//  LogicHandler.swift
//  Restaurant_Bill_Calculator
//
//  Created by Ethayan on 12/09/23.
//

import Foundation

enum Tax {
    static let taxAmount: Double = 2/100
}

enum Group {
    case Group1
    case Group2
    case Group3
}

enum Tab {
    static let TabPrice: Double = 50
}

struct BillHandler {
    let peoples: [String: [FoodItems]]
    var finalPriceforPeople: [String: Double] = [:]
    let paymentMode: PaymentMode
    
    init(peoples: [String: [FoodItems]], paymentMode: PaymentMode) {
        self.peoples = peoples
        self.paymentMode = paymentMode
        callBillCalculator()
    }
    
    mutating func callBillCalculator() {
        switch paymentMode {
        case .cash:
            group1CashBill()
        case .creditCard:
            group2CreditCard()
        case .tab:
            group3()
        }
        
    }
    
    mutating func group1CashBill() {
        var itemsPrice: Double = 0.0
        for (key, values) in peoples {
            let countedSet = NSCountedSet(array: values)
            for value in countedSet {
                itemsPrice = Double(values.compactMap { $0.rawValue *  countedSet.count(for: value) }.reduce(0, +))

            }
            let splitTax = Tax.taxAmount / Double(peoples.keys.count)
            itemsPrice = splitTax * itemsPrice + itemsPrice
            finalPriceforPeople[key] = itemsPrice
        }
        print("Group 1 Each People Food Cost::\n",finalPriceforPeople, "\nTax:", Tax.taxAmount)
    }
    
    mutating func group2CreditCard() {
        var totalPrice: Double = 0.0
        for (people,val) in peoples {
            let totalPrice = Double(val.reduce(0) { $0 + $1.rawValue })
            finalPriceforPeople[people] = totalPrice
        }
        let finalDiscount = discountPrice(discountPercentage: 10, totalPrice: totalPeopleAmount()) // 10% Discount
        let creditSurcharge = creditCardSurcharge(price: finalDiscount) //Surcharge for Creditcard
        totalPrice = Tax.taxAmount * creditSurcharge + creditSurcharge // Tax for Bill
        print("Bill Acount: ", totalPrice, "\nSurCharge: ",  creditSurcharge, "\nTax: ", Tax.taxAmount)
    }
    
    mutating func group3() {
        var totalPrice: Double = 0.0
        for (people,val) in peoples {
            let totalPrice = Double(val.reduce(0) { $0 + $1.rawValue })
            finalPriceforPeople[people] = totalPrice
        }
        totalPrice = totalPeopleAmount()
        totalPrice = totalPrice - Tab.TabPrice //REDUCE FOR TAB
        totalPrice = totalPrice - 25 // $25 doller OFFER
        totalPrice = totalPrice / Double(peoples.keys.count) //split per head equally
        totalPrice = Tax.taxAmount * totalPrice + totalPrice
        print("Bill Amount Per Head:", totalPrice, "\nTax:", Tax.taxAmount)
        
       
    }
    
    func discountPrice(discountPercentage: Double, totalPrice: Double) -> Double {
        let discountPrice = totalPrice/100
       let discountPrice1 = discountPrice * discountPercentage
        return totalPrice - discountPrice1
    }
    
    func creditCardSurcharge(price: Double) -> Double {
        let creditCost = 1.2/100 * price + price
       return  creditCost
    }
    
    func totalPeopleAmount() -> Double {
       let getvalue = finalPriceforPeople.compactMap { $0.value }
        return getvalue.reduce(0, +)
    }
    
}


enum PaymentMode {
    case creditCard
    case cash
    case tab
}


enum FoodItems: Int {
    case bigBrekkie = 16
    case bruchetta = 8
    case poachedEggs = 12
    case coffee = 5
    case tea = 3
    case soda = 4
    case gardenSalad = 10
}

