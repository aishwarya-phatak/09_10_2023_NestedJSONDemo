//
//  ViewController.swift
//  09_10_2023_NestedJSONDemo
//
//  Created by Vishal Jagtap on 25/12/23.
//

import UIKit

class ViewController: UIViewController {

    var products : [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonSerilization()
    }
    
    func jsonSerilization(){
        let url = URL(string: "https://fakestoreapi.com/products")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            
        let jsonResponse = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
            for eachProductResponse in jsonResponse{
                let productDict = eachProductResponse as! [String:Any]
                let productId = productDict["id"] as! Int
                let productTitle = productDict["title"] as! String
                let productPrice = productDict["price"] as! Double
                
                //way 1 -- extracting rating
                let productRating = productDict["rating"] as! [String:Any]
                let productRate = productRating["rate"] as! Double
                let productCount = productRating["count"] as! Int
                
                //way 3- Rating structure nested withon product structure
                let prRating = productDict["rating"] as! Rating
                //object of Rating
                let newRating = Rating(rate: productRate, count: productCount)
                
                let prObject2 = Product2(
                    id: productId,
                    title: productTitle,
                    price: productPrice,
                    rating: newRating)
                
                //way 2
                let prObject1 = Product1(
                    id: productId,
                    title: productTitle,
                    price: productPrice,
                    rating: productRating,
                    rate: productRate,
                    count: productCount)
                
                //way1 -- creating object of Product
                let newProductObject = Product(
                    id: productId,
                    title: productTitle,
                    price: productPrice,
                    rate: productRate,
                    count: productCount)
                self.products.append(newProductObject)
            }
        }
        dataTask.resume()
    }


}

