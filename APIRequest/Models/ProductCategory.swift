//
//  ProductCategory.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 20/08/25.
//

import Foundation

class ProductCategory: Decodable, Identifiable {
    var name: String
    var slug: String
    
    var id: String { name }
    
    enum CodingKeys: CodingKey {
        case name
        case slug
    }
    
    init(name: String, slug: String) {
        self.name = name
        self.slug = slug
    }
    
    var symbolName: String {
        switch name {
            case "Beauty":
                return "sparkles"
            case "Fragrances":
                return "drop.fill"
            case "Furniture":
                return "chair.lounge.fill"
            case "Groceries":
                return "basket.fill"
            case "Home Decoration":
                return "lamp.table.fill"
            case "Kitchen Accessories":
                return "fork.knife"
            case "Laptop":
                return "laptopcomputer"
            case "Mens Shirts":
                return "tshirt.fill"
            case "Mens Shoes":
                return "shoe.fill"
            case "Mens Watches":
                return "applewatch.watchface"
            case "Mobile Accessories":
                return "powercord.fill"
            case "Motorcycle":
                return "motorcycle.fill"
            case "Skin Care":
                return "face.smiling.inverse"
            case "Smartphones":
                return "iphone.gen3"
            case "Sports Accessories":
                return "tennis.racket"
            case "Sunglasses":
                return "sunglasses.fill"
            case "Tablets":
                return "ipad"
            case "Tops":
                return "jacket.fill"
            case "Vehicle":
                return "car.fill"
            case "Womens Bags":
                return "handbag.fill"
            case "Womens Dresses":
                return "figure.stand.dress"
            case "Womens Jewellery":
                return "crown.fill"
            case "Womens Shoes":
                return "shoeprints.fill"
            case "Womens Watches":
                return "watch.analog"
            default:
                return "questionmark.circle" 
        }
    }
    
}

class CategoriesResponse: Decodable {
    var products: [Product]
}
