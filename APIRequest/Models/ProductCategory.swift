//
//  ProductCategory.swift
//  APIRequest
//
//  Created by Gabriel Barbosa on 13/08/25.
//

import Foundation

enum ProductCategory: String, Codable, Identifiable, CaseIterable {
    var id: String { rawValue }
    
    case beauty = "Beauty"
    case fragrances = "Fragrances"
    case furniture = "Furniture"
    case groceries = "Groceries"
    case homeDecoration = "Home-Decoration"
    case kitchenAccessories = "Kitchen-Accessories"
    case laptop = "Laptop"
    case mensShirts = "Mens-Shirts"
    case mensShoes = "Mens-Shoes"
    case mensWatches = "Mens-Watches"
    case mobileAccessories = "Mobile-Accessories"
    case motorcycle = "Motorcycle"
    case skinCare = "Skin-Care"
    case smartphones = "Smartphones"
    case sportsAccessories = "Sports-Accessories"
    case sunglasses = "Sunglasses"
    case tablets = "Tablets"
    case tops = "Tops"
    case vehicle = "Vehicle"
    case womensBags = "Womens-Bags"
    case womensDresses = "Womens-Dresses"
    case womensJewellery = "Womens-Jewellery"
    case womensShoes = "Womens-Shoes"
    case womensWatches = "Womens-Watches"
    
    var imageName: String {
        switch self {
        case .beauty:
            return "sparkles"
        case .fragrances:
            return "drop.fill"
        case .furniture:
            return "chair.lounge.fill"
        case .groceries:
            return "basket.fill"
        case .homeDecoration:
            return "lamp.table.fill"
        case .kitchenAccessories:
            return "fork.knife"
        case .laptop:
            return "laptopcomputer"
        case .mensShirts:
            return "tshirt.fill"
        case .mensShoes:
            return "shoe.fill"
        case .mensWatches:
            return "applewatch.watchface"
        case .mobileAccessories:
            return "powercord.fill"
        case .motorcycle:
            return "motorcycle.fill"
        case .skinCare:
            return "face.smiling.inverse"
        case .smartphones:
            return "iphone.gen3"
        case .sportsAccessories:
            return "tennis.racket"
        case .sunglasses:
            return "sunglasses.fill"
        case .tablets:
            return "ipad"
        case .tops:
            return "jacket.fill"
        case .vehicle:
            return "car.fill"
        case .womensBags:
            return "handbag.fill"
        case .womensDresses:
            return "figure.stand.dress"
        case .womensJewellery:
            return "crown.fill"
        case .womensShoes:
            return "shoeprints.fill"
        case .womensWatches:
            return "watch.analog"
        }
    }
}
