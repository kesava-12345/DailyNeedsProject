import UIKit

struct CategoryDetails {
    var imageName: String
    var title: String
}

class CategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {

    var items = [
            ["Apple", "Fresh red apple, rich in vitamins and antioxidants.", 1.99, "https://example.com/images/apple.jpg"],
            ["Banana", "Ripe bananas, a great source of potassium and energy.", 0.79, "https://example.com/images/banana.jpg"],
            ["Carrot", "Organic carrots, packed with vitamins and perfect for snacking.", 1.49, "https://example.com/images/carrot.jpg"],
            ["Lettuce", "Crisp lettuce leaves, ideal for salads and sandwiches.", 2.49, "https://example.com/images/lettuce.jpg"],
            ["Dark Chocolate", "Rich and smooth dark chocolate, perfect for sweet cravings.", 3.99, "https://example.com/images/dark_chocolate.jpg"],
            ["Milk Chocolate", "Creamy milk chocolate, a classic treat for all ages.", 2.99, "https://example.com/images/milk_chocolate.jpg"],
            ["Vanilla Ice Cream", "Creamy vanilla ice cream made with real vanilla beans.", 4.99, "https://example.com/images/vanilla_ice_cream.jpg"],
            ["Chocolate Ice Cream", "Rich and indulgent chocolate ice cream, a fan favorite.", 5.49, "https://example.com/images/chocolate_ice_cream.jpg"],
            ["Rose", "Beautiful red roses, perfect for gifting or decor.", 12.99, "https://example.com/images/rose.jpg"],
            ["Tulip", "Colorful tulips, a symbol of spring and beauty.", 9.99, "https://example.com/images/tulip.jpg"],
            ["Chips", "Crispy and crunchy potato chips, perfect for snacking.", 2.49, "https://example.com/images/chips.jpg"],
            ["Cookies", "Delicious homemade cookies with chocolate chips.", 3.49, "https://example.com/images/cookies.jpg"],
            ["Peach", "Juicy peaches, a sweet and refreshing summer fruit.", 2.99, "https://example.com/images/peach.jpg"],
            ["Cucumber", "Fresh cucumber, perfect for salads and snacking.", 1.29, "https://example.com/images/cucumber.jpg"],
            ["Milk Chocolate Truffles", "Smooth milk chocolate truffles filled with creamy goodness.", 5.99, "https://example.com/images/chocolate_truffles.jpg"],
            ["Strawberry Ice Cream", "Sweet strawberry ice cream, made with fresh strawberries.", 4.49, "https://example.com/images/strawberry_ice_cream.jpg"]
        ]
    
    var category: [CategoryDetails] = [
          CategoryDetails(imageName: "fruits_and_vegetables", title: "Fruits & Vegetables"),
          CategoryDetails(imageName: "bakery_cakes_and_dairy", title: "Bakery, Cakes & Dairy"),
          CategoryDetails(imageName: "breakfast_and_more", title: "Breakfast & More"),
          CategoryDetails(imageName: "eggs_meat_and_fish", title: "Eggs, Meat & Fish"),
          CategoryDetails(imageName: "masalas_oils_and_dry_fruits", title: "Masalas, Oils & Dry Fruits"),
          CategoryDetails(imageName: "atta_rice_dals_and_sugar", title: "Atta, Rice, Dals & Sugar"),
          CategoryDetails(imageName: "chips_and_biscuits", title: "Chips & Biscuits"),
          CategoryDetails(imageName: "hot_and_cold_beverages", title: "Hot & Cold Beverages"),
          CategoryDetails(imageName: "instant_and_frozen_food", title: "Instant & Frozen Food"),
          CategoryDetails(imageName: "chocolates_and_ice_creams", title: "Chocolates & Ice Creams"),
          CategoryDetails(imageName: "baby_care", title: "Baby Care"),
          CategoryDetails(imageName: "bath_and_body_care", title: "Bath & Body Care"),
          CategoryDetails(imageName: "beauty_and_cosmetics", title: "Beauty & Cosmetics"),
          CategoryDetails(imageName: "health_and_hygiene", title: "Health & Hygiene"),
          CategoryDetails(imageName: "detergents_and_cleaning", title: "Detergents & Cleaning"),
          CategoryDetails(imageName: "kitchen_pooja_and_homeware", title: "Kitchen, Pooja & Homeware"),
          CategoryDetails(imageName: "stationary_and_games", title: "Stationary & Games"),
          CategoryDetails(imageName: "pet_store", title: "Pet Store")
      ]
    
    var filteredCategories: [CategoryDetails] = []
    var collectionView: UICollectionView!
    
    private var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        
        let itemWidth = (self.view.frame.width - 10) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 170)
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Categories"
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func backButtonTapped() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0
            navigationController?.popViewController(animated: true)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCategories.isEmpty ? category.count : filteredCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        
        let categoryDetails = filteredCategories.isEmpty ? category[indexPath.item] : filteredCategories[indexPath.item]
        
        cell.categoryImageView.image = UIImage(named: categoryDetails.imageName)
        cell.titleLabel.text = categoryDetails.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = filteredCategories.isEmpty ? category[indexPath.item] : filteredCategories[indexPath.item]
        
        // Find corresponding item details based on the category selected
        let itemIndex = category.firstIndex(where: { $0.title == selectedCategory.title }) ?? 0
        let selectedItem = items[itemIndex]
        
        // Instantiate the ItemDetailViewController and pass the data
        let itemDetailVC = ItemDetailViewController()
        itemDetailVC.itemTitle = selectedItem[0] as? String
        itemDetailVC.itemDescription = selectedItem[1] as? String
        itemDetailVC.itemPrice = selectedItem[2] as? Double
        itemDetailVC.itemImage = selectedItem[3] as? String
        
       // navigationController?.pushViewController(itemDetailVC, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {
            return
        }
        
        filteredCategories = category.filter { categoryDetails in
            return categoryDetails.title.lowercased().contains(searchText)
        }
        
        collectionView.reloadData()
    }
}

class CategoryCollectionViewCell: UICollectionViewCell {
    let categoryImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.clipsToBounds = true
        contentView.addSubview(categoryImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            categoryImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    func configure(with data: CategoryDetails) {
        categoryImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
    }
}

