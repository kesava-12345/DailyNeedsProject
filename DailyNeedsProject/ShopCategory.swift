import Foundation
import UIKit


class ShopCategory {
    var name: String
    var image: UIImage
    var relatedProducts: [String]

    init(name: String, image: UIImage, relatedProducts: [String]) {
        self.name = name
        self.image = image
        self.relatedProducts = relatedProducts
    }
}


let categories: [ShopCategory] = [
    ShopCategory(name: "Fruits and Vegetables", image: UIImage(systemName: "applelogo")!, relatedProducts: ["Apple", "Banana", "Carrot", "Tomato"]),
    ShopCategory(name: "Bakery, Cakes & Dairy", image: UIImage(systemName: "star")!, relatedProducts: ["Bread", "Cake", "Milk", "Butter"]),
    ShopCategory(name: "Breakfast & More", image: UIImage(systemName: "gift")!, relatedProducts: ["Cereal", "Oats", "Pancakes"]),
    ShopCategory(name: "Eggs, Meat & Fish", image: UIImage(systemName: "heart.fill")!, relatedProducts: ["Eggs", "Chicken", "Fish"]),
    ShopCategory(name: "Masalas, Oils & Dry Fruits", image: UIImage(systemName: "flame")!, relatedProducts: ["Ghee", "Cashews", "Spices"]),
    ShopCategory(name: "Atta, Rice, Dals & Sugar", image: UIImage(systemName: "arrow.right.circle.fill")!, relatedProducts: ["Wheat", "Rice", "Lentils", "Sugar"]),
    ShopCategory(name: "Chips & Biscuits", image: UIImage(systemName: "cart.fill")!, relatedProducts: ["Lays", "Cookies", "Biscuits"]),
    ShopCategory(name: "Hot & Cold Beverages", image: UIImage(systemName: "coffee")!, relatedProducts: ["Tea", "Coffee", "Cold Drinks"]),
    ShopCategory(name: "Instant & Frozen Food", image: UIImage(systemName: "microwave")!, relatedProducts: ["Frozen Pizza", "Instant Noodles"]),
    ShopCategory(name: "Chocolates & Ice Cream", image: UIImage(systemName: "icecream")!, relatedProducts: ["Chocolate Bars", "Ice Cream"]),
    ShopCategory(name: "Gourmet & World Food", image: UIImage(systemName: "globe")!, relatedProducts: ["Sushi", "Pasta", "Cheese"]),
    ShopCategory(name: "Baby Care", image: UIImage(systemName: "baby.carriage")!, relatedProducts: ["Diapers", "Baby Oil", "Baby Food"]),
    ShopCategory(name: "Bath, Body & Hair", image: UIImage(systemName: "soap")!, relatedProducts: ["Shampoo", "Body Lotion", "Soap"]),
    ShopCategory(name: "Beauty & Cosmetics", image: UIImage(systemName: "lipstick")!, relatedProducts: ["Lipstick", "Foundation", "Mascara"]),
    ShopCategory(name: "Health & Hygiene", image: UIImage(systemName: "heart")!, relatedProducts: ["Hand Sanitizer", "Vitamins", "Toothpaste"]),
    ShopCategory(name: "Detergents & Cleaning", image: UIImage(systemName: "brush")!, relatedProducts: ["Dish Soap", "Laundry Detergent"]),
    ShopCategory(name: "Pet Store", image: UIImage(systemName: "pawprint")!, relatedProducts: ["Dog Food", "Cat Toys"]),
    ShopCategory(name: "Kitchen, Pooja & Home Ware", image: UIImage(systemName: "house")!, relatedProducts: ["Pots", "Pooja Thali", "Home Decor"])
]
