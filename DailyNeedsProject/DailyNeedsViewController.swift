import UIKit

struct ImageDetails {
    var imageName: String
    var title: String
    var imageDescription: String
}

class DailyNeedsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var accountButton: UIButton!
    private var searchBar: UISearchBar!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
  
    let sectionTitles = [
        "Shop by Category",
        "Exclusive Stores Bites",
        "Freshness Delivered",
        "A Day Starts Sweetly",
        "Crispy and Tasty",
        "Desserts Delight",
        "Flowers and Leaves"
    ]
    
   

   
    var shopByCategory: [ImageDetails] = [
        ImageDetails(imageName: "fruits_and_vegetables", title: "Fruits & Vegetables", imageDescription: "Fresh fruits and vegetables from local farms."),
        ImageDetails(imageName: "bakery_cakes_and_dairy", title: "Bakery, Cakes & Dairy", imageDescription: "Delicious bakery items, cakes, and fresh dairy products."),
        ImageDetails(imageName: "breakfast_and_more", title: "Breakfast & More", imageDescription: "Complete breakfast items like cereals, bread, and more."),
        ImageDetails(imageName: "eggs_meat_and_fish", title: "Eggs, Meat & Fish", imageDescription: "Fresh eggs, quality meats, and seafood."),
        ImageDetails(imageName: "masalas_oils_and_dry_fruits", title: "Masalas, Oils & Dry Fruits", imageDescription: "Authentic masalas, cooking oils, and dry fruits."),
        ImageDetails(imageName: "atta_rice_dals_and_sugar", title: "Atta, Rice, Dals & Sugar", imageDescription: "Essential pantry items like rice, dals, sugar, and atta."),
        ImageDetails(imageName: "chips_and_biscuits", title: "Chips & Biscuits", imageDescription: "Crunchy chips and crispy biscuits for snacks."),
        ImageDetails(imageName: "hot_and_cold_beverages", title: "Hot & Cold Beverages", imageDescription: "Tea, coffee, juices, and soft drinks for every preference."),
        ImageDetails(imageName: "instant_and_frozen_food", title: "Instant & Frozen Food", imageDescription: "Ready-to-eat meals, frozen foods, and instant snacks."),
        ImageDetails(imageName: "chocolates_and_ice_creams", title: "Chocolates & Ice Creams", imageDescription: "Decadent chocolates and refreshing ice creams."),
        ImageDetails(imageName: "baby_care", title: "Baby Care", imageDescription: "Products for babies including diapers, wipes, and more."),
        ImageDetails(imageName: "bath_and_body_care", title: "Bath & Body Care", imageDescription: "Skincare, haircare, and body care essentials."),
        ImageDetails(imageName: "beauty_and_cosmetics", title: "Beauty & Cosmetics", imageDescription: "Makeup, skincare products, and cosmetics."),
        ImageDetails(imageName: "health_and_hygiene", title: "Health & Hygiene", imageDescription: "Health and hygiene products like sanitizers, vitamins, etc."),
        ImageDetails(imageName: "detergents_and_cleaning", title: "Detergents & Cleaning", imageDescription: "Cleaning supplies, detergents, and disinfectants."),
        ImageDetails(imageName: "kitchen_pooja_and_homeware", title: "Kitchen, Pooja & Homeware", imageDescription: "Kitchen gadgets, pooja items, and home decor."),
        ImageDetails(imageName: "stationary_and_games", title: "Stationary & Games", imageDescription: "Stationary supplies and fun games for all ages."),
        ImageDetails(imageName: "pet_store", title: "Pet Store", imageDescription: "Products for pets including food, toys, and accessories.")
    ]

    
    var exclusiveStoresBites: [ImageDetails] = [
        ImageDetails(imageName: "nuts_and_dry_fruits", title: "Nuts & Dry Fruits", imageDescription: "Premium quality nuts and dry fruits for your health."),
        ImageDetails(imageName: "organic_store", title: "Organic Store", imageDescription: "100% organic products, including food, health items, and more."),
        ImageDetails(imageName: "ayurveda", title: "Ayurveda", imageDescription: "Ayurvedic products for a healthy lifestyle."),
        ImageDetails(imageName: "pooja_store", title: "Pooja Store", imageDescription: "Pooja essentials, incense, and religious items."),
        ImageDetails(imageName: "garden", title: "Garden", imageDescription: "Garden tools, seeds, and plants for your home garden."),
        ImageDetails(imageName: "party_store", title: "Party Store", imageDescription: "Party supplies, decorations, and gift items."),
        ImageDetails(imageName: "gift_store", title: "Gift Store", imageDescription: "Gifts for every occasion, from birthdays to holidays.")
    ]

    
    var freshnessDelivered: [ImageDetails] = [
        ImageDetails(imageName: "fresh_fruits", title: "Fresh Fruits", imageDescription: "Locally sourced fresh fruits delivered to your doorstep."),
        ImageDetails(imageName: "fresh_vegetables", title: "Fresh Vegetables", imageDescription: "Freshly harvested vegetables from local farms."),
        ImageDetails(imageName: "exotic_fruits_and_veggies", title: "Exotic Fruits & Veggies", imageDescription: "Exotic fruits and vegetables from around the world."),
        ImageDetails(imageName: "organic_fruits_and_veggies", title: "Organic Fruits & Veggies", imageDescription: "Organic, pesticide-free fruits and vegetables."),
        ImageDetails(imageName: "seasonal_fruits", title: "Seasonal Fruits", imageDescription: "Fruits that are in season, packed with nutrients.")
    ]

    
    var aDayStartsSweetly: [ImageDetails] = [
        ImageDetails(imageName: "sweets", title: "Sweets", imageDescription: "Traditional sweets made from pure ingredients for a sweet start to the day."),
        ImageDetails(imageName: "gulab_jamun", title: "Gulab Jamun", imageDescription: "Fried dough balls soaked in sugary syrup, a classic Indian dessert."),
        ImageDetails(imageName: "jalebi", title: "Jalebi", imageDescription: "Crispy and syrupy deep-fried sweets in a spiral shape."),
        ImageDetails(imageName: "rasgulla", title: "Rasgulla", imageDescription: "Soft, spongy balls made from chhena soaked in sugary syrup."),
        ImageDetails(imageName: "barfi", title: "Barfi", imageDescription: "A traditional Indian sweet made from condensed milk and sugar, often garnished with nuts."),
        ImageDetails(imageName: "ladoos", title: "Ladoos", imageDescription: "Round sweets made from various ingredients like gram flour, coconut, or semolina."),
        ImageDetails(imageName: "peda", title: "Peda", imageDescription: "A dense milk-based sweet often flavored with cardamom and topped with pistachios."),
        ImageDetails(imageName: "kalakand", title: "Kalakand", imageDescription: "A moist, milk-based sweet flavored with rose water and garnished with almonds."),
        ImageDetails(imageName: "sohan_halwa", title: "Sohan Halwa", imageDescription: "A rich and sweet dessert made from sugar, ghee, and flour."),
        ImageDetails(imageName: "kheer", title: "Kheer", imageDescription: "A creamy rice pudding made with milk, rice, and cardamom."),
        ImageDetails(imageName: "chumchum", title: "Chumchum", imageDescription: "Sweet, spongy dumplings made from chhena, often dipped in sugary syrup."),
        ImageDetails(imageName: "moong_dal_halwa", title: "Moong Dal Halwa", imageDescription: "A rich dessert made from yellow lentils, ghee, and sugar, often enjoyed in the winter.")
    ]

   
    var crispyAndTasty: [ImageDetails] = [
        ImageDetails(imageName: "kurkure", title: "Kurkure", imageDescription: "Crunchy and spicy snack for every occasion."),
        ImageDetails(imageName: "namkin", title: "Namkin", imageDescription: "Savory and crispy snacks to satisfy your cravings."),
        ImageDetails(imageName: "bhujia", title: "Bhujia", imageDescription: "Crispy fried snacks made from gram flour, flavored with spices."),
        ImageDetails(imageName: "chips", title: "Chips", imageDescription: "Thinly sliced, crispy potato chips available in a variety of flavors."),
        ImageDetails(imageName: "popped_rice", title: "Popped Rice", imageDescription: "Light and crunchy puffed rice often eaten as a snack."),
        ImageDetails(imageName: "peanuts", title: "Peanuts", imageDescription: "Roasted peanuts that are crunchy and salty, perfect for snacking."),
        ImageDetails(imageName: "bhel_puri", title: "Bhel Puri", imageDescription: "A savory and crunchy puffed rice snack mixed with tangy chutneys and spices."),
        ImageDetails(imageName: "sev", title: "Sev", imageDescription: "Thin, crunchy fried noodles made from gram flour, a popular snack in Indian cuisine."),
        ImageDetails(imageName: "munch", title: "Munch", imageDescription: "A crunchy, chocolate-covered snack bar."),
        ImageDetails(imageName: "crisps", title: "Crisps", imageDescription: "Thinly sliced, deep-fried crispy snacks, available in various flavors."),
        ImageDetails(imageName: "patties", title: "Patties", imageDescription: "Small, crispy pastries filled with savory fillings like potatoes, peas, or meat."),
        ImageDetails(imageName: "nachos", title: "Nachos", imageDescription: "Crispy tortilla chips often served with cheese, salsa, and guacamole.")
    ]

   
    var dessertsDelight: [ImageDetails] = [
        ImageDetails(imageName: "ice_creams", title: "Ice Creams", imageDescription: "A variety of ice creams in different flavors to satisfy your sweet tooth."),
        ImageDetails(imageName: "cake", title: "Cake", imageDescription: "Moist and delicious cakes, available in chocolate, vanilla, and more."),
        ImageDetails(imageName: "brownies", title: "Brownies", imageDescription: "Rich and fudgy chocolate brownies, perfect for dessert."),
        ImageDetails(imageName: "cookies", title: "Cookies", imageDescription: "Soft and chewy cookies available in different flavors like chocolate chip and oatmeal."),
        ImageDetails(imageName: "cheesecake", title: "Cheesecake", imageDescription: "A smooth and creamy dessert made with cream cheese, often topped with fruit or chocolate."),
        ImageDetails(imageName: "tiramisu", title: "Tiramisu", imageDescription: "A layered Italian dessert made with coffee-soaked ladyfingers and mascarpone cheese."),
        ImageDetails(imageName: "pudding", title: "Pudding", imageDescription: "Rich and creamy custard pudding made with milk, eggs, and sugar."),
        ImageDetails(imageName: "macarons", title: "Macarons", imageDescription: "Delicate, almond-flavored cookies filled with flavored buttercream or ganache."),
        ImageDetails(imageName: "cupcakes", title: "Cupcakes", imageDescription: "Miniature cakes topped with creamy frosting and sprinkles."),
        ImageDetails(imageName: "mousse", title: "Mousse", imageDescription: "A light and airy dessert made from whipped cream and flavored with chocolate, fruit, or coffee."),
        ImageDetails(imageName: "falooda", title: "Falooda", imageDescription: "A sweet, milky drink with rose syrup, vermicelli, and basil seeds, served cold."),
        ImageDetails(imageName: "kulfi", title: "Kulfi", imageDescription: "Indian ice cream made with thickened milk, often flavored with cardamom or pistachio.")
    ]

  
    var flowersAndLeaves: [ImageDetails] = [
        ImageDetails(imageName: "flowers", title: "Flowers", imageDescription: "Freshly picked flowers for every occasion."),
        ImageDetails(imageName: "roses", title: "Roses", imageDescription: "Elegant and fragrant roses in various colors."),
        ImageDetails(imageName: "lilies", title: "Lilies", imageDescription: "Beautiful lilies with a sweet fragrance, perfect for gifting."),
        ImageDetails(imageName: "orchids", title: "Orchids", imageDescription: "Exotic and vibrant orchids to add elegance to any room."),
        ImageDetails(imageName: "tulips", title: "Tulips", imageDescription: "Colorful and fresh tulips to brighten up your day."),
        ImageDetails(imageName: "sunflowers", title: "Sunflowers", imageDescription: "Bright and cheerful sunflowers to bring joy to your space."),
        ImageDetails(imageName: "daisies", title: "Daisies", imageDescription: "Simple and beautiful daisies, perfect for any occasion."),
        ImageDetails(imageName: "lavender", title: "Lavender", imageDescription: "Fragrant lavender flowers, known for their calming aroma."),
        ImageDetails(imageName: "hibiscus", title: "Hibiscus", imageDescription: "Exotic hibiscus flowers, often used in teas and oils."),
        ImageDetails(imageName: "bouquet", title: "Bouquet", imageDescription: "A carefully arranged bouquet of fresh flowers, perfect for gifting."),
        ImageDetails(imageName: "leaves", title: "Leaves", imageDescription: "Beautiful leaves, perfect for decoration and ceremonies."),
        ImageDetails(imageName: "ferns", title: "Ferns", imageDescription: "Lush, green ferns that make for great indoor plants and decor.")
    ]

    
   
    var verticalProductData: [[ImageDetails]] = []
    var horizontalProductData: [[ImageDetails]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .white
        setupUI()
        setupScrollView()
        
        
        verticalProductData = [
            shopByCategory,
            exclusiveStoresBites,
            freshnessDelivered
        ]
        
        horizontalProductData = [
            aDayStartsSweetly,
            crispyAndTasty,
            dessertsDelight,
            flowersAndLeaves
        ]
    }
    
    private func setupUI() {
      
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 16, y: 80, width: view.frame.width - 32, height: 40)
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        view.addSubview(stackView)
        
        let titleLabel = UILabel()
        let titleText = "Daily Needs"
        let attributedString = NSMutableAttributedString(string: titleText)
        
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: 5))
        
       
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 6, length: 5))
        
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 24), range: NSRange(location: 0, length: titleText.count))
        
        titleLabel.attributedText = attributedString
        titleLabel.backgroundColor = UIColor.clear
        
        stackView.addArrangedSubview(titleLabel)
//        print("Title Label Text: \(titleLabel.text ?? "")")
        
        let timerLabel = UILabel()
        timerLabel.text = "12 mins"
        timerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
    
        timerLabel.textColor = UIColor.systemBlue
        timerLabel.backgroundColor = UIColor.clear
        stackView.addArrangedSubview(timerLabel)
        
      
        accountButton = UIButton(type: .custom)
        accountButton.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        accountButton.setImage(UIImage(systemName: "person.fill"), for: .normal)
        accountButton.backgroundColor = UIColor.white
        accountButton.layer.cornerRadius = 2
        accountButton.layer.masksToBounds = true
        accountButton.layer.borderColor = UIColor.darkGray.cgColor
        accountButton.layer.borderWidth = 2
        accountButton.layer.shadowColor = UIColor.black.cgColor
        accountButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        accountButton.layer.shadowRadius = 5
        accountButton.layer.shadowOpacity = 0.2
        accountButton.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(accountButton)
        
  
        searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 16, y: 130, width: view.frame.width - 32, height: 40) // Search bar moved up a bit
        searchBar.placeholder = "Search for items"
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 10
        searchBar.clipsToBounds = true
        view.addSubview(searchBar)
    }

    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 180, width: view.frame.width, height: view.frame.height - 180) // Below the search bar
        scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        var yOffset: CGFloat = 0
        let titleHeight: CGFloat = 40
        
        for (index, title) in sectionTitles.enumerated() {
            // Section Title Label
            let sectionTitleLabel = UILabel(frame: CGRect(x: 16, y: yOffset, width: view.frame.width - 32 - 40, height: titleHeight)) // Adjust width to leave space for arrow
            sectionTitleLabel.text = title
            sectionTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
            sectionTitleLabel.textColor = UIColor.black
            contentView.addSubview(sectionTitleLabel)
            
            // Arrow Button
            let arrowButton = UIButton(type: .custom)
            arrowButton.frame = CGRect(x: view.frame.width - 50, y: yOffset + (titleHeight - 24) / 2, width: 24, height: 24) // Position it on the right
            arrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            arrowButton.tintColor = UIColor.blue
            arrowButton.layer.borderWidth = 1
            arrowButton.layer.borderColor = UIColor.lightGray.cgColor
            arrowButton.layer.cornerRadius = 5
            arrowButton.layer.masksToBounds = true
            arrowButton.addTarget(self, action: #selector(navigateToSectionDetail), for: .touchUpInside)
            arrowButton.tag = index
            contentView.addSubview(arrowButton)
            
            yOffset += titleHeight
            
            // Collection View
            let isVertical = index < 3
            let collectionView: UICollectionView
            
            if isVertical {
                // Vertical collection view
                collectionView = createVerticalCollectionView()
                collectionView.frame = CGRect(x: 16, y: yOffset, width: view.frame.width - 32, height: 200)
                collectionView.tag = index // Tag to identify which section to use
                contentView.addSubview(collectionView)
                yOffset += 200
            } else {
                // Horizontal collection view
                collectionView = createHorizontalCollectionView()
                collectionView.frame = CGRect(x: 16, y: yOffset, width: view.frame.width - 32, height: 200)
                collectionView.tag = index // Tag to identify which section to use
                contentView.addSubview(collectionView)
                yOffset += 200
            }
        }
        
        // Adjust content view size based on total yOffset
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: yOffset)
        scrollView.contentSize = contentView.frame.size
    }

   

    
    // Create Vertical Collection View
    func createVerticalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: (view.frame.width - 64) / 3, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }
    
    // Create Horizontal Collection View
    func createHorizontalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 150) 
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }
    
    @objc func navigateToSectionDetail(_ sender: UIButton) {
        
        let sectionIndex = sender.tag
        let sectionTitle = sectionTitles[sectionIndex]
        var sectionItems: [ImageDetails] = []

        switch sectionIndex {
        case 0:
            sectionItems = shopByCategory
        case 1:
            sectionItems = exclusiveStoresBites
        case 2:
            sectionItems = freshnessDelivered
        case 3:
            sectionItems = aDayStartsSweetly
        case 4:
            sectionItems = crispyAndTasty
        case 5:
            sectionItems = dessertsDelight
        case 6:
            sectionItems = flowersAndLeaves
        default:
            break
        }
        let sectionDetailVC = SectionDetailViewController()
        sectionDetailVC.sectionTitle = sectionTitle
        sectionDetailVC.sectionItems = sectionItems

        navigationController?.pushViewController(sectionDetailVC, animated: true)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let index = collectionView.tag

        if index < 3 {
            return verticalProductData[index].count
        } else {
            return horizontalProductData[index - 3].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let index = collectionView.tag
        let data: ImageDetails
        
        if index < 3 {
            data = verticalProductData[index][indexPath.item]
        } else {
            data = horizontalProductData[index - 3][indexPath.item]
        }
        
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.image = UIImage(named: data.imageName)
        cell.contentView.addSubview(imageView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 110, width: 100, height: 30))
        titleLabel.text = data.title
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        cell.contentView.addSubview(titleLabel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected at index \(indexPath.item)")
    }
    
    @objc func accountButtonTapped() {
        let userDetailsVC = UserDetailsViewController()
        navigationController?.pushViewController(userDetailsVC, animated: true)
    }


}
