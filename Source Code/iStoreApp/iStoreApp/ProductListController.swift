//
//  ProductListController.swift
//  iStoreApp
//
//  Created by Zaiyang Li on 02/11/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit
import Moltin

class ProductListController : UITableViewController {
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Moltin.sharedInstance().product.search(withParameters: ["name": ""], success: { (response: [AnyHashable : Any]?) in
            if response != nil{
                self.setProducts(json: response!)
            }
        }) { (response: [AnyHashable : Any]?, error:Error?) in
            
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView
            .dequeueReusableCell(withIdentifier: ProductListItem.CellIdentifier, for: indexPath)
            as! ProductListItem
        cell.product = products[indexPath.row]
        return cell
    }
    func setProducts(json:[AnyHashable: Any]){
        typealias Json = [AnyHashable: Any]
        products = [];
        let result = json["result"] as! [Json]
        
        for productJson in result {
            let title = productJson["title"] as! String
                let priceJson = productJson["price"] as! Json
                    let price = priceJson["value"] as! String
            print(productJson["images"])
            let imageJson = (productJson["images"] as! [AnyObject])[0]
            let imageUrlJson = imageJson["url"] as! Json
                    let imageUrl = URL(string: imageUrlJson["https"] as! String)
            let product = Product(title: title, price: price, imageUrl: imageUrl)
            products.append(product)
        }
        
        tableView.reloadData()
    }
}
