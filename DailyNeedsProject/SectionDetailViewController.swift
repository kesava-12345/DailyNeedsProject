import UIKit

class ProductDetails {
    var productName: String
    var description: String
    var price: Double
    var imageName: String
    var quantity: Int  
    
    init(productName: String, description: String, price: Double, imageName: String, quantity: Int = 1) {
        self.productName = productName
        self.description = description
        self.price = price
        self.imageName = imageName
        self.quantity = quantity
    }
}

class SectionDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UIScrollViewDelegate {
    
    var shopByCategoryWithItems: [[ProductDetails]] = [
        // Fruits & Vegetables
        [
            ProductDetails(productName: "Apple", description: "Fresh and crispy apples, perfect for snacking or baking.", price: 3.99, imageName: "apple_image"),
            ProductDetails(productName: "Banana", description: "Sweet and ripe bananas, a great source of potassium.", price: 1.99, imageName: "banana_image"),
            ProductDetails(productName: "Carrot", description: "Fresh and crunchy carrots, great for salads or snacks.", price: 2.49, imageName: "carrot_image")
        ],
        
        // Bakery, Cakes & Dairy
        [
            ProductDetails(productName: "Bread", description: "Soft and fluffy bread, ideal for sandwiches or toast.", price: 1.50, imageName: "bread_image"),
            ProductDetails(productName: "Chocolate Cake", description: "Delicious chocolate cake with a rich, creamy frosting.", price: 5.99, imageName: "chocolate_cake_image"),
            ProductDetails(productName: "Milk", description: "Fresh, full-fat milk, great for drinking or adding to your coffee.", price: 1.79, imageName: "milk_image")
        ],
        
        // Breakfast & More
        [
            ProductDetails(productName: "Cereal", description: "Healthy and crunchy cereal, perfect for a quick breakfast.", price: 3.99, imageName: "cereal_image"),
            ProductDetails(productName: "Oats", description: "Whole oats, great for making porridge or baking.", price: 2.49, imageName: "oats_image"),
            ProductDetails(productName: "Honey", description: "Pure and natural honey, perfect for your morning tea or toast.", price: 4.99, imageName: "honey_image")
        ],
        
        // Eggs, Meat & Fish
        [
            ProductDetails(productName: "Eggs", description: "Fresh eggs, a great source of protein and perfect for any meal.", price: 2.49, imageName: "eggs_image"),
            ProductDetails(productName: "Chicken Breast", description: "Tender and lean chicken breast, great for grilling or stir-fries.", price: 5.99, imageName: "chicken_breast_image"),
            ProductDetails(productName: "Salmon", description: "Fresh salmon fillets, rich in omega-3 fatty acids.", price: 8.99, imageName: "salmon_image")
        ],
        
        // Masalas, Oils & Dry Fruits
        [
            ProductDetails(productName: "Garam Masala", description: "A blend of aromatic spices for Indian cooking.", price: 1.99, imageName: "garam_masala_image"),
            ProductDetails(productName: "Olive Oil", description: "Cold-pressed olive oil, great for cooking or dressing salads.", price: 6.49, imageName: "olive_oil_image"),
            ProductDetails(productName: "Cashews", description: "Roasted and salted cashew nuts, perfect for snacking.", price: 4.99, imageName: "cashews_image")
        ],
        
        // Atta, Rice, Dals & Sugar
        [
            ProductDetails(productName: "Wheat Atta", description: "Whole wheat flour, perfect for making rotis and chapatis.", price: 2.29, imageName: "wheat_atta_image"),
            ProductDetails(productName: "Basmati Rice", description: "Long-grain basmati rice, fragrant and perfect for biryanis.", price: 3.49, imageName: "basmati_rice_image"),
            ProductDetails(productName: "Sugar", description: "Refined sugar, perfect for baking and sweetening your drinks.", price: 2.19, imageName: "sugar_image")
        ],
        
        // Chips & Biscuits
        [
            ProductDetails(productName: "Potato Chips", description: "Crispy and salty potato chips, a perfect snack.", price: 1.99, imageName: "potato_chips_image"),
            ProductDetails(productName: "Cheese Biscuits", description: "Savory biscuits with a cheesy flavor, perfect for tea time.", price: 2.49, imageName: "cheese_biscuits_image"),
            ProductDetails(productName: "Oreo Cookies", description: "Delicious chocolate sandwich cookies with a creamy filling.", price: 3.49, imageName: "oreo_cookies_image")
        ],
        
        // Hot & Cold Beverages
        [
            ProductDetails(productName: "Tea Bags", description: "A pack of refreshing tea bags, perfect for any time of the day.", price: 2.99, imageName: "tea_bags_image"),
            ProductDetails(productName: "Coffee Powder", description: "Rich and aromatic coffee powder, great for brewing fresh coffee.", price: 4.49, imageName: "coffee_powder_image"),
            ProductDetails(productName: "Orange Juice", description: "Freshly squeezed orange juice, rich in vitamin C.", price: 3.19, imageName: "orange_juice_image")
        ],
        
        // Instant & Frozen Food
        [
            ProductDetails(productName: "Instant Noodles", description: "Quick and easy to make noodles, perfect for a fast meal.", price: 1.49, imageName: "instant_noodles_image"),
            ProductDetails(productName: "Frozen Pizza", description: "Ready-to-bake frozen pizza with cheese and toppings.", price: 5.99, imageName: "frozen_pizza_image"),
            ProductDetails(productName: "Frozen French Fries", description: "Crispy and golden fries, ready to cook straight from the freezer.", price: 3.29, imageName: "frozen_fries_image")
        ],
        
        // Chocolates & Ice Creams
        [
            ProductDetails(productName: "Dark Chocolate", description: "Rich and smooth dark chocolate, perfect for chocolate lovers.", price: 2.99, imageName: "dark_chocolate_image"),
            ProductDetails(productName: "Vanilla Ice Cream", description: "Creamy vanilla ice cream, a classic treat for any time of day.", price: 4.49, imageName: "vanilla_ice_cream_image"),
            ProductDetails(productName: "Chocolate Bars", description: "Indulgent chocolate bars with rich fillings.", price: 1.99, imageName: "chocolate_bars_image")
        ],
        
        // Baby Care
        [
            ProductDetails(productName: "Diapers", description: "Soft and absorbent diapers, perfect for babies.", price: 8.99, imageName: "diapers_image"),
            ProductDetails(productName: "Baby Wipes", description: "Gentle wipes for cleaning your baby’s delicate skin.", price: 3.49, imageName: "baby_wipes_image"),
            ProductDetails(productName: "Baby Lotion", description: "Moisturizing lotion for keeping baby’s skin soft and smooth.", price: 4.99, imageName: "baby_lotion_image")
        ],
        
        // Bath & Body Care
        [
            ProductDetails(productName: "Shampoo", description: "Gentle shampoo for clean and shiny hair.", price: 2.99, imageName: "shampoo_image"),
            ProductDetails(productName: "Body Lotion", description: "Rich body lotion for soft and hydrated skin.", price: 3.49, imageName: "body_lotion_image"),
            ProductDetails(productName: "Soap Bar", description: "Refreshing soap bar for a clean and soft skin.", price: 1.99, imageName: "soap_bar_image")
        ],
        
        // Beauty & Cosmetics
        [
            ProductDetails(productName: "Foundation", description: "Smooth foundation for flawless skin.", price: 7.99, imageName: "foundation_image"),
            ProductDetails(productName: "Lipstick", description: "Long-lasting lipstick available in various shades.", price: 4.99, imageName: "lipstick_image"),
            ProductDetails(productName: "Eyeliner", description: "Precise and smudge-proof eyeliner for bold eyes.", price: 3.49, imageName: "eyeliner_image")
        ],
        
        // Health & Hygiene
        [
            ProductDetails(productName: "Hand Sanitizer", description: "Kills 99.9% of germs, keeps your hands clean.", price: 2.49, imageName: "hand_sanitizer_image"),
            ProductDetails(productName: "Vitamins", description: "Daily multivitamins to support overall health.", price: 6.99, imageName: "vitamins_image"),
            ProductDetails(productName: "Face Masks", description: "Disposable face masks, great for hygiene and protection.", price: 1.99, imageName: "face_masks_image")
        ],
        
        // Detergents & Cleaning
        [
            ProductDetails(productName: "Dishwashing Liquid", description: "Effective dishwashing liquid for clean dishes.", price: 1.89, imageName: "dishwashing_liquid_image"),
            ProductDetails(productName: "Laundry Detergent", description: "Powerful detergent for fresh and clean clothes.", price: 4.29, imageName: "laundry_detergent_image"),
            ProductDetails(productName: "All-Purpose Cleaner", description: "Multi-surface cleaner, great for every part of your home.", price: 3.49, imageName: "all_purpose_cleaner_image")
        ],
        
        [
            ProductDetails(productName: "Mixer", description: "Effective dishwashing liquid for clean dishes.", price: 1.89, imageName: "mixer_image"),
            ProductDetails(productName: "Doobsticks", description: "Powerful detergent for fresh and clean clothes.", price: 4.29, imageName: "doobsticks_image"),
            ProductDetails(productName: "Wall Stickers", description: "Multi-surface cleaner, great for every part of your home.", price: 3.49, imageName: "wall_stickers_image")
        ],
        
        [
            ProductDetails(productName: "Pen", description: "Effective dishwashing liquid for clean dishes.", price: 1.89, imageName: "pen_image"),
            ProductDetails(productName: "Blockus", description: "Powerful detergent for fresh and clean clothes.", price: 4.29, imageName: "blockus_image"),
            ProductDetails(productName: "Uno Cards", description: "Multi-surface cleaner, great for every part of your home.", price: 3.49, imageName: "uno_cards_image")
        ],
        
        [
            ProductDetails(productName: "Pedigree", description: "Effective dishwashing liquid for clean dishes.", price: 1.89, imageName: "pedigree_image"),
            ProductDetails(productName: "Tiro Bolt Ring", description: "Powerful detergent for fresh and clean clothes.", price: 4.29, imageName: "tiro_bolt_ring_image"),
            ProductDetails(productName: "Belt", description: "Multi-surface cleaner, great for every part of your home.", price: 3.49, imageName: "belt_image")
        ]
    ]


    var exclusiveStoresBitesWithItems: [[ProductDetails]] = [
        // Nuts & Dry Fruits
        [
            ProductDetails(productName: "Almonds", description: "Premium quality almonds, rich in vitamins and healthy fats.", price: 5.99, imageName: "almonds_image"),
            ProductDetails(productName: "Cashews", description: "Roasted and salted cashews, perfect for snacking or adding to recipes.", price: 4.99, imageName: "cashews_image"),
            ProductDetails(productName: "Pistachios", description: "Fresh pistachios, a great source of protein and fiber.", price: 6.49, imageName: "pistachios_image")
        ],
        
        // Organic Store
        [
            ProductDetails(productName: "Organic Rice", description: "100% organic basmati rice, grown without pesticides.", price: 3.99, imageName: "organic_rice_image"),
            ProductDetails(productName: "Organic Honey", description: "Pure organic honey, harvested from local hives.", price: 7.49, imageName: "organic_honey_image"),
            ProductDetails(productName: "Organic Green Tea", description: "High-quality organic green tea, perfect for a refreshing drink.", price: 4.99, imageName: "organic_green_tea_image")
        ],
        
        // Ayurveda
        [
            ProductDetails(productName: "Aloe Vera Gel", description: "Natural aloe vera gel, great for skin hydration and healing.", price: 5.49, imageName: "aloe_vera_gel_image"),
            ProductDetails(productName: "Ashwagandha Powder", description: "Ayurvedic ashwagandha powder, known for reducing stress and boosting immunity.", price: 3.99, imageName: "ashwagandha_powder_image"),
            ProductDetails(productName: "Triphala Powder", description: "A potent herbal powder mix for digestive health and detoxification.", price: 4.49, imageName: "triphala_powder_image")
        ],
        
        // Pooja Store
        [
            ProductDetails(productName: "Pooja Thali", description: "Traditional pooja thali for religious rituals and prayers.", price: 6.99, imageName: "pooja_thali_image"),
            ProductDetails(productName: "Incense Sticks", description: "Fragrant incense sticks for pooja and meditation.", price: 2.49, imageName: "incense_sticks_image"),
            ProductDetails(productName: "Brass Bell", description: "A brass bell used during pooja ceremonies for a divine sound.", price: 3.99, imageName: "brass_bell_image")
        ],
        
        // Garden
        [
            ProductDetails(productName: "Gardening Tools Set", description: "A set of essential tools for maintaining your garden.", price: 12.99, imageName: "gardening_tools_set_image"),
            ProductDetails(productName: "Flower Seeds", description: "A variety of flower seeds, perfect for planting in your garden.", price: 2.99, imageName: "flower_seeds_image"),
            ProductDetails(productName: "Indoor Plants", description: "Low-maintenance indoor plants that brighten up your home.", price: 5.49, imageName: "indoor_plants_image")
        ],
        
        // Party Store
        [
            ProductDetails(productName: "Balloon Pack", description: "Colorful balloons for parties, available in different shapes and sizes.", price: 3.99, imageName: "balloon_pack_image"),
            ProductDetails(productName: "Party Hats", description: "Fun party hats for every celebration.", price: 2.49, imageName: "party_hats_image"),
            ProductDetails(productName: "Birthday Cake Candles", description: "A pack of vibrant candles for your birthday cake.", price: 1.99, imageName: "birthday_cake_candles_image")
        ],
        
        // Gift Store
        [
            ProductDetails(productName: "Personalized Mug", description: "A customized mug with your name or message, perfect for gifting.", price: 4.99, imageName: "personalized_mug_image"),
            ProductDetails(productName: "Gift Basket", description: "A beautiful gift basket filled with chocolates, nuts, and treats.", price: 12.99, imageName: "gift_basket_image"),
            ProductDetails(productName: "Plush Teddy Bear", description: "A soft and cuddly teddy bear, perfect for gifting to loved ones.", price: 6.49, imageName: "plush_teddy_bear_image")
        ]
    ]


    var freshnessDeliveredWithItems: [[ProductDetails]] = [
        // Fresh Fruits
        [
            ProductDetails(productName: "Apple", description: "Fresh and crispy apples, perfect for snacking or baking.", price: 3.99, imageName: "apple_image"),
            ProductDetails(productName: "Banana", description: "Sweet and ripe bananas, a great source of potassium.", price: 1.99, imageName: "banana_image"),
            ProductDetails(productName: "Mango", description: "Juicy and tropical mangoes, rich in vitamins and flavor.", price: 2.99, imageName: "mango_image")
        ],
        
        // Fresh Vegetables
        [
            ProductDetails(productName: "Carrot", description: "Fresh and crunchy carrots, great for salads or snacks.", price: 2.49, imageName: "carrot_image"),
            ProductDetails(productName: "Cucumber", description: "Refreshing cucumbers, perfect for salads or sandwiches.", price: 1.99, imageName: "cucumber_image"),
            ProductDetails(productName: "Tomato", description: "Ripe tomatoes, ideal for cooking or adding to salads.", price: 2.79, imageName: "tomato_image")
        ],
        
        // Exotic Fruits & Veggies
        [
            ProductDetails(productName: "Dragon Fruit", description: "Exotic and vibrant dragon fruit, full of antioxidants.", price: 5.99, imageName: "dragon_fruit_image"),
            ProductDetails(productName: "Kiwi", description: "Tart and sweet kiwi, packed with vitamin C.", price: 3.49, imageName: "kiwi_image"),
            ProductDetails(productName: "Zucchini", description: "Tender zucchini, great for stir-fries or salads.", price: 2.99, imageName: "zucchini_image")
        ],
        
        // Organic Fruits & Veggies
        [
            ProductDetails(productName: "Organic Apple", description: "Pesticide-free apples, fresh and crunchy.", price: 4.99, imageName: "organic_apple_image"),
            ProductDetails(productName: "Organic Spinach", description: "Fresh organic spinach, rich in vitamins and minerals.", price: 3.29, imageName: "organic_spinach_image"),
            ProductDetails(productName: "Organic Tomato", description: "Juicy organic tomatoes, perfect for cooking or salads.", price: 3.99, imageName: "organic_tomato_image")
        ],
        
        // Seasonal Fruits
        [
            ProductDetails(productName: "Peach", description: "Sweet and juicy peaches, available during the summer season.", price: 3.79, imageName: "peach_image"),
            ProductDetails(productName: "Grapes", description: "Fresh, plump grapes, perfect for snacking or adding to fruit salads.", price: 4.49, imageName: "grapes_image"),
            ProductDetails(productName: "Pineapple", description: "Tangy and tropical pineapple, perfect for smoothies or fruit bowls.", price: 3.99, imageName: "pineapple_image")
        ]
    ]


    
    var aDayStartsSweetlyWithItems: [[ProductDetails]] = [
        // Sweets
        [
            ProductDetails(productName: "Jalebi", description: "Crispy and syrupy deep-fried sweets in a spiral shape.", price: 3.49, imageName: "jalebi_image"),
            ProductDetails(productName: "Barfi", description: "A traditional Indian sweet made from condensed milk and sugar, often garnished with nuts.", price: 5.99, imageName: "barfi_image"),
            ProductDetails(productName: "Gulab Jamun", description: "Fried dough balls soaked in sugary syrup, a classic Indian dessert.", price: 4.99, imageName: "gulab_jamun_image")
        ],
        
        // Gulab Jamun
        [
            ProductDetails(productName: "Gulab Jamun", description: "Soft, round dumplings made from milk solids, deep-fried and soaked in rose-flavored syrup.", price: 6.49, imageName: "gulab_jamun_classic_image"),
            ProductDetails(productName: "Chocolate Gulab Jamun", description: "Gulab Jamun with a decadent chocolate filling, combining two favorite sweets.", price: 7.99, imageName: "chocolate_gulab_jamun_image"),
            ProductDetails(productName: "Mini Gulab Jamun", description: "Smaller version of the traditional gulab jamun, perfect for bite-sized indulgence.", price: 3.99, imageName: "mini_gulab_jamun_image")
        ],
        
        // Jalebi
        [
            ProductDetails(productName: "Classic Jalebi", description: "Golden, crispy spirals drenched in sugar syrup, a delightful sweet treat.", price: 2.99, imageName: "classic_jalebi_image"),
            ProductDetails(productName: "Pineapple Jalebi", description: "A twist on the classic, with the sweetness of pineapple infused in the syrup.", price: 3.49, imageName: "pineapple_jalebi_image"),
            ProductDetails(productName: "Mango Jalebi", description: "Tangy mango-flavored syrup soaked into crispy, spiral jalebis.", price: 3.99, imageName: "mango_jalebi_image")
        ],
        
        // Rasgulla
        [
            ProductDetails(productName: "Classic Rasgulla", description: "Soft, spongy balls made from chhena soaked in sugary syrup.", price: 4.99, imageName: "classic_rasgulla_image"),
            ProductDetails(productName: "Rasgulla with Rose", description: "Rasgullas flavored with a hint of rose water, adding a fragrant twist.", price: 5.49, imageName: "rasgulla_with_rose_image"),
            ProductDetails(productName: "Rasgulla with Saffron", description: "Rasgullas soaked in saffron-infused syrup for an aromatic touch.", price: 5.99, imageName: "rasgulla_with_saffron_image")
        ],
        
        // Barfi
        [
            ProductDetails(productName: "Kaju Barfi", description: "A rich barfi made with cashew nuts and sugar, cut into diamond shapes.", price: 6.99, imageName: "kaju_barfi_image"),
            ProductDetails(productName: "Pista Barfi", description: "Barfi made with pistachios, offering a nutty and creamy texture.", price: 5.49, imageName: "pista_barfi_image"),
            ProductDetails(productName: "Mawa Barfi", description: "Made from mawa (condensed milk), sugar, and ghee, garnished with nuts.", price: 4.99, imageName: "mawa_barfi_image")
        ],
        
        // Ladoos
        [
            ProductDetails(productName: "Besan Ladoo", description: "Delicious round sweets made from gram flour, ghee, and sugar.", price: 4.49, imageName: "besan_ladoo_image"),
            ProductDetails(productName: "Coconut Ladoo", description: "Coconut-flavored ladoos, perfect for those who love tropical sweets.", price: 3.99, imageName: "coconut_ladoo_image"),
            ProductDetails(productName: "Boondi Ladoo", description: "Sweet, round ladoos made from crispy boondi soaked in sugar syrup.", price: 5.49, imageName: "boondi_ladoo_image")
        ],
        
        // Peda
        [
            ProductDetails(productName: "Mawa Peda", description: "A dense, rich milk-based sweet flavored with cardamom and topped with pistachios.", price: 6.49, imageName: "mawa_peda_image"),
            ProductDetails(productName: "Pista Peda", description: "Peda made with pistachios for a nutty, creamy flavor.", price: 5.99, imageName: "pista_peda_image"),
            ProductDetails(productName: "Kesar Peda", description: "A saffron-flavored peda, aromatic and rich in taste.", price: 7.49, imageName: "kesar_peda_image")
        ],
        
        // Kalakand
        [
            ProductDetails(productName: "Traditional Kalakand", description: "A moist, milk-based sweet flavored with rose water and garnished with almonds.", price: 4.99, imageName: "traditional_kalakand_image"),
            ProductDetails(productName: "Chocolate Kalakand", description: "Kalakand flavored with rich chocolate for a unique twist.", price: 5.99, imageName: "chocolate_kalakand_image"),
            ProductDetails(productName: "Mango Kalakand", description: "A seasonal variation of kalakand with mango puree for a fruity touch.", price: 5.49, imageName: "mango_kalakand_image")
        ],
        
        // Sohan Halwa
        [
            ProductDetails(productName: "Classic Sohan Halwa", description: "A rich, sweet dessert made from sugar, ghee, and flour, often enjoyed in winter.", price: 6.99, imageName: "classic_sohan_halwa_image"),
            ProductDetails(productName: "Pistachio Sohan Halwa", description: "Sohan Halwa enriched with pistachio flavor for added richness.", price: 7.49, imageName: "pistachio_sohan_halwa_image"),
            ProductDetails(productName: "Saffron Sohan Halwa", description: "A unique saffron-infused version of the classic sohan halwa.", price: 7.99, imageName: "saffron_sohan_halwa_image")
        ],
        
        // Kheer
        [
            ProductDetails(productName: "Traditional Kheer", description: "A creamy rice pudding made with milk, rice, and cardamom.", price: 3.99, imageName: "traditional_kheer_image"),
            ProductDetails(productName: "Fruit Kheer", description: "Rice kheer with seasonal fruits mixed in for added flavor.", price: 4.49, imageName: "fruit_kheer_image"),
            ProductDetails(productName: "Saffron Kheer", description: "Kheer flavored with fragrant saffron for an aromatic experience.", price: 5.49, imageName: "saffron_kheer_image")
        ],
        
        // Chumchum
        [
            ProductDetails(productName: "Classic Chumchum", description: "Sweet, spongy dumplings made from chhena, often dipped in sugary syrup.", price: 4.99, imageName: "classic_chumchum_image"),
            ProductDetails(productName: "Chumchum with Coconut", description: "Chumchums topped with grated coconut for a crunchy twist.", price: 5.49, imageName: "chumchum_with_coconut_image"),
            ProductDetails(productName: "Chumchum with Saffron", description: "Chumchums flavored with saffron syrup for a fragrant finish.", price: 5.99, imageName: "chumchum_with_saffron_image")
        ],
        
        // Moong Dal Halwa
        [
            ProductDetails(productName: "Traditional Moong Dal Halwa", description: "A rich dessert made from yellow lentils, ghee, and sugar, often enjoyed in winter.", price: 5.99, imageName: "traditional_moong_dal_halwa_image"),
            ProductDetails(productName: "Cashew Moong Dal Halwa", description: "Moong dal halwa with cashew nuts for an extra crunch and richness.", price: 6.49, imageName: "cashew_moong_dal_halwa_image"),
            ProductDetails(productName: "Saffron Moong Dal Halwa", description: "Moong dal halwa flavored with saffron for an aromatic twist.", price: 6.99, imageName: "saffron_moong_dal_halwa_image")
        ]
    ]


    var crispyAndTastyWithItems: [[ProductDetails]] = [
        // Kurkure
        [
            ProductDetails(productName: "Kurkure Classic", description: "Crunchy, spicy snack with a tangy flavor, perfect for munching anytime.", price: 2.49, imageName: "kurkure_classic_image"),
            ProductDetails(productName: "Kurkure Masala Munch", description: "A masala-flavored version of the popular Kurkure snack, bursting with spices.", price: 2.99, imageName: "kurkure_masala_munch_image"),
            ProductDetails(productName: "Kurkure Green Chutney", description: "A zesty green chutney-flavored Kurkure for a refreshing kick.", price: 3.49, imageName: "kurkure_green_chutney_image")
        ],
        
        // Namkin
        [
            ProductDetails(productName: "Crispy Namkin", description: "Savory and crunchy, this namkin snack is perfect for tea time.", price: 1.99, imageName: "crispy_namkin_image"),
            ProductDetails(productName: "Spicy Namkin", description: "A spicy version of namkin with bold flavors and extra heat.", price: 2.49, imageName: "spicy_namkin_image"),
            ProductDetails(productName: "Salted Namkin", description: "Lightly salted namkin with a satisfying crunch.", price: 2.99, imageName: "salted_namkin_image")
        ],
        
        // Bhujia
        [
            ProductDetails(productName: "Classic Bhujia", description: "Crunchy, fried snacks made from gram flour and a blend of spices.", price: 3.49, imageName: "classic_bhujia_image"),
            ProductDetails(productName: "Masala Bhujia", description: "Bhujia with a spicy masala twist, perfect for snacking.", price: 3.99, imageName: "masala_bhujia_image"),
            ProductDetails(productName: "Sev Bhujia", description: "A mix of crispy sev and bhujia, flavored with tangy spices.", price: 4.29, imageName: "sev_bhujia_image")
        ],
        
        // Chips
        [
            ProductDetails(productName: "Classic Potato Chips", description: "Thinly sliced, crispy potato chips, lightly salted.", price: 1.99, imageName: "classic_potato_chips_image"),
            ProductDetails(productName: "BBQ Flavored Chips", description: "Crispy chips with a smoky BBQ flavor, perfect for snacking.", price: 2.49, imageName: "bbq_flavored_chips_image"),
            ProductDetails(productName: "Cheese Flavored Chips", description: "Crispy potato chips with a cheesy, savory flavor.", price: 2.99, imageName: "cheese_flavored_chips_image")
        ],
        
        // Popped Rice
        [
            ProductDetails(productName: "Classic Popped Rice", description: "Light and crispy popped rice, a light snack for any time of the day.", price: 1.49, imageName: "classic_popped_rice_image"),
            ProductDetails(productName: "Spicy Popped Rice", description: "Popped rice with a spicy masala flavor, perfect for those who love a little heat.", price: 1.99, imageName: "spicy_popped_rice_image"),
            ProductDetails(productName: "Sweet Popped Rice", description: "A sweeter version of popped rice, with a touch of sugar.", price: 2.29, imageName: "sweet_popped_rice_image")
        ],
        
        // Peanuts
        [
            ProductDetails(productName: "Roasted Salted Peanuts", description: "Crunchy roasted peanuts lightly salted for a perfect snack.", price: 2.49, imageName: "roasted_salted_peanuts_image"),
            ProductDetails(productName: "Honey Roasted Peanuts", description: "Peanuts roasted in a sweet honey glaze, combining sweetness and saltiness.", price: 3.49, imageName: "honey_roasted_peanuts_image"),
            ProductDetails(productName: "Spicy Peanuts", description: "Roasted peanuts with a kick of spicy seasoning.", price: 2.99, imageName: "spicy_peanuts_image")
        ],
        
        // Bhel Puri
        [
            ProductDetails(productName: "Classic Bhel Puri", description: "A savory puffed rice snack mixed with tangy chutneys and spices.", price: 2.99, imageName: "classic_bhel_puri_image"),
            ProductDetails(productName: "Spicy Bhel Puri", description: "Bhel Puri with an extra spicy twist for those who love heat.", price: 3.49, imageName: "spicy_bhel_puri_image"),
            ProductDetails(productName: "Sweet Bhel Puri", description: "A sweetened version of Bhel Puri, with a balance of sweet and sour chutneys.", price: 3.29, imageName: "sweet_bhel_puri_image")
        ],
        
        // Sev
        [
            ProductDetails(productName: "Classic Sev", description: "Thin, crunchy fried noodles made from gram flour, perfect as a snack or topping.", price: 2.49, imageName: "classic_sev_image"),
            ProductDetails(productName: "Masala Sev", description: "Crispy sev with a spicy masala coating, adding a burst of flavor.", price: 2.99, imageName: "masala_sev_image"),
            ProductDetails(productName: "Plain Sev", description: "Light and simple sev, offering a crispy, mild taste.", price: 2.79, imageName: "plain_sev_image")
        ],
        
        // Munch
        [
            ProductDetails(productName: "Munch Classic", description: "A crunchy, chocolate-covered snack bar that satisfies your sweet and crunchy cravings.", price: 1.99, imageName: "munch_classic_image"),
            ProductDetails(productName: "Munch Caramel", description: "Munch bar with a layer of creamy caramel for a richer flavor.", price: 2.49, imageName: "munch_caramel_image"),
            ProductDetails(productName: "Munch Hazelnut", description: "Munch bar with a crunchy hazelnut filling covered in chocolate.", price: 2.79, imageName: "munch_hazelnut_image")
        ],
        
        // Crisps
        [
            ProductDetails(productName: "Classic Potato Crisps", description: "Thinly sliced, deep-fried crispy potato crisps with a salty flavor.", price: 1.99, imageName: "classic_potato_crisps_image"),
            ProductDetails(productName: "Salt and Vinegar Crisps", description: "Crisps with a tangy salt and vinegar flavor for a refreshing twist.", price: 2.49, imageName: "salt_and_vinegar_crisps_image"),
            ProductDetails(productName: "Cheese and Onion Crisps", description: "Crisps with a savory cheese and onion flavor combination.", price: 2.79, imageName: "cheese_and_onion_crisps_image")
        ],
        
        // Patties
        [
            ProductDetails(productName: "Potato Patties", description: "Crispy pastries filled with seasoned mashed potatoes.", price: 3.49, imageName: "potato_patties_image"),
            ProductDetails(productName: "Paneer Patties", description: "Crispy pastries filled with a spiced paneer (Indian cottage cheese) filling.", price: 4.29, imageName: "paneer_patties_image"),
            ProductDetails(productName: "Chicken Patties", description: "Crispy pastry filled with spiced minced chicken for a savory treat.", price: 4.99, imageName: "chicken_patties_image")
        ],
        
        // Nachos
        [
            ProductDetails(productName: "Classic Nachos", description: "Crispy tortilla chips served with a side of cheese and salsa.", price: 2.99, imageName: "classic_nachos_image"),
            ProductDetails(productName: "Cheese Nachos", description: "Nachos topped with melted cheese and served with salsa and guacamole.", price: 3.49, imageName: "cheese_nachos_image"),
            ProductDetails(productName: "Spicy Nachos", description: "Crispy tortilla chips with a spicy seasoning, served with cheese and salsa.", price: 3.99, imageName: "spicy_nachos_image")
        ]
    ]

    var dessertsDelightWithItems: [[ProductDetails]] = [
        // Ice Creams
        [
            ProductDetails(productName: "Vanilla Ice Cream", description: "Classic creamy vanilla ice cream, perfect for any occasion.", price: 3.49, imageName: "vanilla_ice_cream_image"),
            ProductDetails(productName: "Chocolate Ice Cream", description: "Rich and creamy chocolate ice cream for all chocolate lovers.", price: 3.99, imageName: "chocolate_ice_cream_image"),
            ProductDetails(productName: "Strawberry Ice Cream", description: "Sweet and tangy strawberry ice cream made with fresh strawberries.", price: 3.79, imageName: "strawberry_ice_cream_image")
        ],
        
        // Cake
        [
            ProductDetails(productName: "Chocolate Cake", description: "Moist, rich chocolate cake with a smooth chocolate ganache.", price: 5.49, imageName: "chocolate_cake_image"),
            ProductDetails(productName: "Vanilla Cake", description: "Fluffy and soft vanilla cake, perfect with a cup of tea or coffee.", price: 4.99, imageName: "vanilla_cake_image"),
            ProductDetails(productName: "Red Velvet Cake", description: "Delicious red velvet cake with cream cheese frosting.", price: 6.49, imageName: "red_velvet_cake_image")
        ],
        
        // Brownies
        [
            ProductDetails(productName: "Classic Brownie", description: "Rich, fudgy brownies made with high-quality cocoa and a hint of vanilla.", price: 2.99, imageName: "classic_brownie_image"),
            ProductDetails(productName: "Peanut Butter Brownie", description: "Decadent chocolate brownies with a creamy peanut butter swirl.", price: 3.49, imageName: "peanut_butter_brownie_image"),
            ProductDetails(productName: "Triple Chocolate Brownie", description: "Fudgy brownies with dark, milk, and white chocolate pieces throughout.", price: 3.79, imageName: "triple_chocolate_brownie_image")
        ],
        
        // Cookies
        [
            ProductDetails(productName: "Chocolate Chip Cookies", description: "Soft, chewy cookies filled with rich chocolate chips.", price: 2.49, imageName: "chocolate_chip_cookies_image"),
            ProductDetails(productName: "Oatmeal Raisin Cookies", description: "Chewy oatmeal cookies with a hint of cinnamon and plump raisins.", price: 2.79, imageName: "oatmeal_raisin_cookies_image"),
            ProductDetails(productName: "Peanut Butter Cookies", description: "Delicious, soft cookies with a creamy peanut butter flavor.", price: 2.99, imageName: "peanut_butter_cookies_image")
        ],
        
        // Cheesecake
        [
            ProductDetails(productName: "Classic Cheesecake", description: "Rich, smooth cheesecake with a buttery graham cracker crust.", price: 4.99, imageName: "classic_cheesecake_image"),
            ProductDetails(productName: "Strawberry Cheesecake", description: "Classic cheesecake topped with fresh, sweet strawberry compote.", price: 5.49, imageName: "strawberry_cheesecake_image"),
            ProductDetails(productName: "Chocolate Cheesecake", description: "Creamy cheesecake with a layer of decadent chocolate ganache.", price: 5.99, imageName: "chocolate_cheesecake_image")
        ],
        
        // Tiramisu
        [
            ProductDetails(productName: "Classic Tiramisu", description: "A layered Italian dessert with coffee-soaked ladyfingers and mascarpone cheese.", price: 5.49, imageName: "classic_tiramisu_image"),
            ProductDetails(productName: "Chocolate Tiramisu", description: "A twist on the classic with rich chocolate layers mixed with mascarpone.", price: 5.99, imageName: "chocolate_tiramisu_image"),
            ProductDetails(productName: "Strawberry Tiramisu", description: "A refreshing variation with fresh strawberries added to the traditional tiramisu.", price: 6.49, imageName: "strawberry_tiramisu_image")
        ],
        
        // Pudding
        [
            ProductDetails(productName: "Vanilla Pudding", description: "Classic creamy vanilla custard, smooth and comforting.", price: 2.49, imageName: "vanilla_pudding_image"),
            ProductDetails(productName: "Chocolate Pudding", description: "Rich, velvety chocolate pudding made with premium cocoa.", price: 2.99, imageName: "chocolate_pudding_image"),
            ProductDetails(productName: "Butterscotch Pudding", description: "Creamy butterscotch pudding with a sweet caramel flavor.", price: 3.29, imageName: "butterscotch_pudding_image")
        ],
        
        // Macarons
        [
            ProductDetails(productName: "Classic Vanilla Macaron", description: "Delicate almond-flavored macaron filled with creamy vanilla buttercream.", price: 1.99, imageName: "vanilla_macaron_image"),
            ProductDetails(productName: "Raspberry Macaron", description: "Sweet and tart raspberry macaron with a tangy raspberry filling.", price: 2.49, imageName: "raspberry_macaron_image"),
            ProductDetails(productName: "Chocolate Macaron", description: "Rich chocolate macaron with smooth chocolate ganache filling.", price: 2.79, imageName: "chocolate_macaron_image")
        ],
        
        // Cupcakes
        [
            ProductDetails(productName: "Chocolate Cupcake", description: "Moist chocolate cupcake topped with a creamy chocolate frosting.", price: 2.49, imageName: "chocolate_cupcake_image"),
            ProductDetails(productName: "Vanilla Cupcake", description: "Soft vanilla cupcake topped with light vanilla frosting and sprinkles.", price: 2.79, imageName: "vanilla_cupcake_image"),
            ProductDetails(productName: "Red Velvet Cupcake", description: "Delicious red velvet cupcake topped with cream cheese frosting.", price: 3.29, imageName: "red_velvet_cupcake_image")
        ],
        
        // Mousse
        [
            ProductDetails(productName: "Chocolate Mousse", description: "Rich and airy chocolate mousse with a velvety smooth texture.", price: 3.99, imageName: "chocolate_mousse_image"),
            ProductDetails(productName: "Strawberry Mousse", description: "Light and airy mousse flavored with fresh strawberries.", price: 4.29, imageName: "strawberry_mousse_image"),
            ProductDetails(productName: "Coffee Mousse", description: "A rich coffee mousse, perfect for coffee lovers with a creamy texture.", price: 4.49, imageName: "coffee_mousse_image")
        ],
        
        // Falooda
        [
            ProductDetails(productName: "Classic Falooda", description: "A sweet, milky drink with rose syrup, vermicelli, and basil seeds, served cold.", price: 3.49, imageName: "classic_falooda_image"),
            ProductDetails(productName: "Mango Falooda", description: "Falooda with a tropical twist, flavored with sweet mango syrup.", price: 4.29, imageName: "mango_falooda_image"),
            ProductDetails(productName: "Strawberry Falooda", description: "A refreshing falooda with sweet strawberry syrup and basil seeds.", price: 4.49, imageName: "strawberry_falooda_image")
        ],
        
        // Kulfi
        [
            ProductDetails(productName: "Traditional Kulfi", description: "Rich and creamy Indian ice cream made with thickened milk, often flavored with cardamom.", price: 3.99, imageName: "traditional_kulfi_image"),
            ProductDetails(productName: "Pistachio Kulfi", description: "Kulfi flavored with pistachios, offering a nutty and creamy taste.", price: 4.29, imageName: "pistachio_kulfi_image"),
            ProductDetails(productName: "Mango Kulfi", description: "A refreshing kulfi made with ripe mangoes for a tropical flavor.", price: 4.49, imageName: "mango_kulfi_image")
        ]
    ]

    var flowersAndLeavesWithItems: [[ProductDetails]] = [
        // Flowers
        [
            ProductDetails(productName: "Red Roses", description: "Fresh red roses, symbolizing love and passion.", price: 9.99, imageName: "red_roses_image"),
            ProductDetails(productName: "White Roses", description: "Elegant white roses, representing purity and innocence.", price: 10.49, imageName: "white_roses_image"),
            ProductDetails(productName: "Yellow Roses", description: "Bright yellow roses, symbolizing friendship and joy.", price: 8.99, imageName: "yellow_roses_image")
        ],
        
        // Roses
        [
            ProductDetails(productName: "Pink Roses", description: "Soft and sweet pink roses for every occasion.", price: 7.99, imageName: "pink_roses_image"),
            ProductDetails(productName: "Orange Roses", description: "Vibrant orange roses for a warm and energetic feel.", price: 10.29, imageName: "orange_roses_image"),
            ProductDetails(productName: "Lavender Roses", description: "Delicate lavender roses with a subtle fragrance.", price: 9.49, imageName: "lavender_roses_image")
        ],
        
        // Lilies
        [
            ProductDetails(productName: "White Lilies", description: "Pure white lilies with a sweet, fragrant aroma.", price: 12.99, imageName: "white_lilies_image"),
            ProductDetails(productName: "Pink Lilies", description: "Gentle pink lilies, perfect for gifting or decorating.", price: 11.49, imageName: "pink_lilies_image"),
            ProductDetails(productName: "Tiger Lilies", description: "Exotic tiger lilies with bold orange and black markings.", price: 14.29, imageName: "tiger_lilies_image")
        ],
        
        // Orchids
        [
            ProductDetails(productName: "Purple Orchids", description: "Elegant purple orchids, perfect for luxury arrangements.", price: 15.99, imageName: "purple_orchids_image"),
            ProductDetails(productName: "White Orchids", description: "Graceful white orchids that bring an air of sophistication.", price: 16.49, imageName: "white_orchids_image"),
            ProductDetails(productName: "Yellow Orchids", description: "Vibrant yellow orchids, adding brightness to your decor.", price: 14.99, imageName: "yellow_orchids_image")
        ],
        
        // Tulips
        [
            ProductDetails(productName: "Red Tulips", description: "Bright red tulips symbolizing passion and elegance.", price: 7.99, imageName: "red_tulips_image"),
            ProductDetails(productName: "Purple Tulips", description: "Elegant purple tulips that add a touch of grace.", price: 8.49, imageName: "purple_tulips_image"),
            ProductDetails(productName: "Pink Tulips", description: "Fresh pink tulips, perfect for spring arrangements.", price: 8.99, imageName: "pink_tulips_image")
        ],
        
        // Sunflowers
        [
            ProductDetails(productName: "Sunflower Bouquet", description: "A stunning bouquet of bright sunflowers that bring sunshine indoors.", price: 14.99, imageName: "sunflower_bouquet_image"),
            ProductDetails(productName: "Mini Sunflowers", description: "Small sunflowers that can brighten up any space.", price: 9.49, imageName: "mini_sunflowers_image"),
            ProductDetails(productName: "Dwarf Sunflowers", description: "Compact sunflowers that are perfect for smaller spaces or pots.", price: 8.79, imageName: "dwarf_sunflowers_image")
        ],
        
        // Daisies
        [
            ProductDetails(productName: "White Daisies", description: "Simple white daisies symbolizing purity and new beginnings.", price: 5.99, imageName: "white_daisies_image"),
            ProductDetails(productName: "Yellow Daisies", description: "Bright yellow daisies, perfect for cheerful arrangements.", price: 6.49, imageName: "yellow_daisies_image"),
            ProductDetails(productName: "Gerbera Daisies", description: "Vibrant Gerbera daisies in a mix of colors for any occasion.", price: 7.29, imageName: "gerbera_daisies_image")
        ],
        
        // Lavender
        [
            ProductDetails(productName: "Fresh Lavender Bunch", description: "A fragrant bunch of fresh lavender, perfect for calming your senses.", price: 8.99, imageName: "fresh_lavender_bunch_image"),
            ProductDetails(productName: "Dried Lavender", description: "Dried lavender flowers that are perfect for potpourri and sachets.", price: 6.49, imageName: "dried_lavender_image"),
            ProductDetails(productName: "Lavender Wreath", description: "A beautiful wreath made from dried lavender, perfect for home decor.", price: 12.49, imageName: "lavender_wreath_image")
        ],
        
        // Hibiscus
        [
            ProductDetails(productName: "Red Hibiscus", description: "Exotic red hibiscus flowers, known for their rich color and beauty.", price: 7.99, imageName: "red_hibiscus_image"),
            ProductDetails(productName: "Pink Hibiscus", description: "Soft pink hibiscus flowers, adding elegance to any arrangement.", price: 8.49, imageName: "pink_hibiscus_image"),
            ProductDetails(productName: "Hibiscus Tea Leaves", description: "Dried hibiscus flowers that can be brewed into a refreshing herbal tea.", price: 5.79, imageName: "hibiscus_tea_leaves_image")
        ],
        
        // Bouquet
        [
            ProductDetails(productName: "Mixed Flower Bouquet", description: "A vibrant bouquet of mixed flowers for every occasion.", price: 19.99, imageName: "mixed_flower_bouquet_image"),
            ProductDetails(productName: "Rose and Lily Bouquet", description: "A stunning bouquet combining roses and lilies for elegance.", price: 22.49, imageName: "rose_and_lily_bouquet_image"),
            ProductDetails(productName: "Sunflower and Daisy Bouquet", description: "A cheerful and bright bouquet of sunflowers and daisies.", price: 17.99, imageName: "sunflower_and_daisy_bouquet_image")
        ],
        
        // Leaves
        [
            ProductDetails(productName: "Palm Leaves", description: "Large, decorative palm leaves, perfect for tropical decor.", price: 6.99, imageName: "palm_leaves_image"),
            ProductDetails(productName: "Banana Leaves", description: "Large, green banana leaves used for decoration and ceremonial purposes.", price: 5.49, imageName: "banana_leaves_image"),
            ProductDetails(productName: "Monstera Leaves", description: "Stylish monstera leaves, perfect for adding a tropical touch to your space.", price: 8.29, imageName: "monstera_leaves_image")
        ],
        
        // Ferns
        [
            ProductDetails(productName: "Boston Fern", description: "A lush green Boston fern that adds life to any room.", price: 11.99, imageName: "boston_fern_image"),
            ProductDetails(productName: "Maidenhair Fern", description: "A delicate maidenhair fern with soft, feathery leaves.", price: 12.49, imageName: "maidenhair_fern_image"),
            ProductDetails(productName: "Sword Fern", description: "A sturdy and attractive sword fern, ideal for indoor gardens.", price: 10.79, imageName: "sword_fern_image")
        ]
    ]



    var sectionTitle: String!
    var sectionItems: [ImageDetails]!
    var originalSectionItems: [ImageDetails]!
    
    private var collectionView: UICollectionView!
    
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionView()
 
        originalSectionItems = sectionItems
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = sectionTitle
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
       
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func searchButtonTapped() {
        if searchController == nil {
            presentSearchController()
        }
        navigationItem.searchController = searchController
    }
    
    private func presentSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search items"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionView() {
        // Set up collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        // Adjust item size to fit two items per row
        let numberOfItemsPerRow: CGFloat = 2
        let padding: CGFloat = 16
        let itemWidth = (view.frame.width - padding * 3) / numberOfItemsPerRow
        let itemHeight: CGFloat = 170
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        // Initialize collection view
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        // Register custom cell
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCell")
        
        // Add collection view to the view hierarchy
        view.addSubview(collectionView)
        
        // Set collection view constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as! DetailCollectionViewCell
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        
        let data = sectionItems[indexPath.item]

        cell.configure(with: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = sectionItems[indexPath.item]
        
        var productsToShow: [ProductDetails] = []

        let exclusiveCategoryNames = [
            "Nuts & Dry Fruits", "Organic Store", "Ayurveda", "Pooja Store", "Garden", "Party Store", "Gift Store"
        ]
        
        let freshnessCategoryNames = [
            "Fresh Fruits", "Fresh Vegetables", "Exotic Fruits & Veggies", "Organic Fruits & Veggies", "Seasonal Fruits"
        ]
        
        let shopByCategoryNames = [
            "Fruits & Vegetables", "Bakery, Cakes & Dairy", "Breakfast & More", "Eggs, Meat & Fish", "Masalas, Oils & Dry Fruits",
            "Atta, Rice, Dals & Sugar", "Chips & Biscuits", "Hot & Cold Beverages", "Instant & Frozen Food", "Chocolates & Ice Creams",
            "Baby Care", "Bath & Body Care", "Beauty & Cosmetics", "Health & Hygiene", "Detergents & Cleaning"
        ]
        
        let dessertsCategoryNames = [
            "Ice Creams", "Cake", "Brownies", "Cookies", "Cheesecake", "Tiramisu", "Pudding", "Macarons", "Cupcakes", "Mousse", "Falooda", "Kulfi"
        ]
        
        let flowersCategoryNames = [
            "Flowers", "Roses", "Lilies", "Orchids", "Tulips", "Sunflowers", "Daisies", "Lavender", "Hibiscus", "Bouquet", "Leaves", "Ferns"
        ]
        
        let aDayStartsSweetlyCategoryNames = [
            "Sweets", "Gulab Jamun", "Jalebi", "Rasgulla", "Barfi", "Ladoos", "Peda", "Kalakand", "Sohan Halwa", "Kheer", "Chumchum", "Moong Dal Halwa"
        ]
        
        let crispyAndTastyCategoryNames = [
            "Kurkure", "Namkin", "Bhujia", "Chips", "Popped Rice", "Peanuts", "Bhel Puri", "Sev", "Munch", "Crisps", "Patties", "Nachos"
        ]
        
        if let index = exclusiveCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = exclusiveStoresBitesWithItems[index]
        }
        
        else if let index = freshnessCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = freshnessDeliveredWithItems[index]
        }
        
        else if let index = shopByCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = shopByCategoryWithItems[index]
        }
        
        else if let index = dessertsCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = dessertsDelightWithItems[index]
        }
        
        else if let index = flowersCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = flowersAndLeavesWithItems[index]
        }
        
        else if let index = aDayStartsSweetlyCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = aDayStartsSweetlyWithItems[index]
        }
        
        else if let index = crispyAndTastyCategoryNames.firstIndex(of: selectedItem.title) {
            productsToShow = crispyAndTastyWithItems[index]
        }
        
        let productDetailVC = ProductDetailViewController()
        productDetailVC.products = productsToShow
       // navigationController?.pushViewController(productDetailVC, animated: true)
    }


    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            // Reset to original data if the search is cleared
            sectionItems = originalSectionItems
            collectionView.reloadData()
            return
        }
        
        // Filter the sectionItems based on the search text
        sectionItems = originalSectionItems.filter { item in
            item.title.lowercased().contains(searchText.lowercased())
        }
        
        collectionView.reloadData()
    }
 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the searchController is not nil and is active
        guard let searchController = searchController, searchController.isActive else { return }
        
        // When scrolling down, dismiss the search bar
        if scrollView.contentOffset.y > 0 {
            searchController.searchBar.resignFirstResponder()
        }
    }
}


import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Set up the image view
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        // Set up the title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        // Set constraints for the image view and label with 10-point padding on all sides
        NSLayoutConstraint.activate([
            // Image view constraints with 10-point padding around it
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 120),  // Fixed image height
            
            // Title label constraints with 10-point padding
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with data: ImageDetails) {
        imageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
    }
}
