//
//  Product.swift
//  iStoreApp
//
//  Created by Zaiyang Li on 02/11/2016.
//  Copyright © 2016 Zaiyang Li. All rights reserved.
//

import Foundation

struct Product {
    var title: String?
    var price: String?
    var imageUrl: URL?
    
    init(title: String?, price: String?, imageUrl: URL?) {
        self.title = title
        self.price = price
        self.imageUrl = imageUrl
    }
}
