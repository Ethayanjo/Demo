//
//  ContentView.swift
//  Restaurant_Bill_Calculator
//
//  Created by Ethayan on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    
    static let group1FoodData = ["ravi":[.bigBrekkie,
                                         .bruchetta, .poachedEggs, .coffee,
                                         .tea,
                                         .soda],
                                 
                                 "anand":[.bigBrekkie, .bruchetta, .poachedEggs,
                                          .coffee,
                                          .soda],
                                 
                                 "michel":[FoodItems.bigBrekkie, .bruchetta, .poachedEggs,
                                           .tea,
                                           .soda]
                                 
    ]
    
    static let group2FoodData = ["jhon":[.tea,
                                         .gardenSalad
                                         ],
                                 
                                 "frank":[FoodItems.coffee,
                                          .bigBrekkie],
                                 
                                 "steve":[.poachedEggs,
                                          .coffee],
                                 
                                 "mark": [.soda,
                                          .bigBrekkie],
                                 
                                 "joy": [.coffee,
                                         .bigBrekkie]]
    
    static let group3FoodData = ["matheve":[.tea,
                                         .gardenSalad
                                         ],
                                 
                                 "frank":[FoodItems.tea,
                                          .bigBrekkie,
                                          .bruchetta],
                                 
                                 "miran":[.poachedEggs,
                                          .soda,
                                          .gardenSalad],
                                 
                                 "mark": [.soda,
                                          .bigBrekkie,
                                          .bruchetta,
                                          .poachedEggs],
                                 
                                 "joy": [.coffee,
                                         .bigBrekkie,
                                         .bruchetta,
                                         .gardenSalad],
                                 "rule": [.coffee,
                                         .bigBrekkie,
                                          .bruchetta],
                                 "mike": [.coffee,
                                         .bigBrekkie,
                                          .bruchetta,
                                          .gardenSalad]
    ]
    
    
    
    @State var logicHandler: BillHandler = BillHandler(peoples: [:], paymentMode: .cash)
    var body: some View {
        Text("Tap Below Button For Action")
        
        VStack(spacing: 20) {
            Button("Cash Group1", action: {
                logicHandler = BillHandler(peoples: ContentView.group1FoodData, paymentMode: .cash)
            })
            Button("Credit Card Group2", action: {
                logicHandler = BillHandler(peoples: ContentView.group2FoodData, paymentMode: .creditCard)
            })
            Button("Tab Group3", action: {
                logicHandler = BillHandler(peoples: ContentView.group3FoodData, paymentMode: .tab)
            })
        }
        Text("You can see values in Print")
        .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
