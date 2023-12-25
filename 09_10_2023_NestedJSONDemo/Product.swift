//
//  Product.swift
//  09_10_2023_NestedJSONDemo
//
//  Created by Vishal Jagtap on 25/12/23.
//

import Foundation
//way1
struct Product{
    var id : Int
    var title : String
    var price : Double
    var rate : Double
    var count : Int
}

//way 2
struct Product1{
    var id : Int
    var title : String
    var price : Double
    var rating : [String:Any]
    var rate : Double
    var count : Int
}


//way 3 -- nesting Rating structure inside Product structure
struct Product2{
    var id : Int
    var title : String
    var price : Double
    var rating : Rating
}

struct Rating{
    var rate : Double
    var count : Int
}
