//
//  ViewController.swift
//  09_10_2023_NestedJSONDemo
//
//  Created by Vishal Jagtap on 25/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    private let productTableViewCellIdentifier = "ProductTableViewCell"
    private let productDetailsViewControllerIdentifier = "ProductDetailsViewController"
    var products : [Product] = []
    var uiNib : UINib?
    var productTableViewCell : ProductTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializationOfTableView()
        registerXIBWithTableView()
        jsonSerilization()
    }
    
    func initializationOfTableView(){
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    
    func registerXIBWithTableView(){
        uiNib = UINib(nibName: productTableViewCellIdentifier, bundle: nil)
        self.productTableView.register(uiNib, forCellReuseIdentifier: productTableViewCellIdentifier)
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
                let prRating = productDict["rating"] as! [String:Any]
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
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        productTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: productTableViewCellIdentifier, for: indexPath) as? ProductTableViewCell
        
        productTableViewCell?.prIdLabel.text = String(products[indexPath.row].id)
        productTableViewCell?.prRateLabel.text = String(products[indexPath.row].rate)
        productTableViewCell?.prCountLabel.text = String(products[indexPath.row].count)
        
        return productTableViewCell!
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: productDetailsViewControllerIdentifier) as? ProductDetailsViewController
        
        prDetailsViewController?.productContainer = products[indexPath.row]
        
        self.navigationController?.pushViewController(prDetailsViewController!, animated: true)
    }
}
