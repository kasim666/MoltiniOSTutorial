//
//  ProductListItem.swift
//  iStoreApp
//
//  Created by Zaiyang Li on 02/11/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import UIKit

class ProductListItem : UITableViewCell {
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
    static let CellIdentifier = "ProductListCell"
    var product: Product! {
        didSet {
            titleLabel.text = product.title
            priceLabel.text = product.price
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: self.product.imageUrl!)
                DispatchQueue.main.async {
                    self.productImage.image = UIImage(data: data!)
                }
            }
        }
    }
    
}
