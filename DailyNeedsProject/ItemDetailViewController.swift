import UIKit

class ItemDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var itemTitle: String?
    var itemDescription: String?
    var itemPrice: Double?
    var itemImage: String?
    
    var itemCount = 1 // Default item count
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        setupNavigationBar() // Setup the basket icon on the navigation bar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupTableView() {
        // Set up tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemDetailTableViewCell.self, forCellReuseIdentifier: "ItemDetailCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // Set the basket button on the navigation bar
    private func setupNavigationBar() {
        let basketButton = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(basketButtonTapped))
        navigationItem.rightBarButtonItem = basketButton
    }

    // Action when the basket button is tapped
    @objc private func basketButtonTapped() {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 3 // Assuming Basket tab is at index 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    // TableView data source and delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Just one row for the item details
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailCell", for: indexPath) as! ItemDetailTableViewCell
        
        // Configure cell with item data
        cell.itemImageView.image = UIImage(named: itemImage ?? "")
        cell.itemNameLabel.text = itemTitle
        cell.itemDescriptionLabel.text = itemDescription
        cell.itemPriceLabel.text = "Price: $\(itemPrice ?? 0.0)"
        
        // Set the stepper value to current count
        cell.quantityStepper.value = Double(itemCount)
        
        // Add action for stepper to update itemCount
        cell.quantityStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)

        // Add action for "Add to Basket" button
        cell.addToBasketButton.addTarget(self, action: #selector(addToBasketButtonTapped), for: .touchUpInside)
        
        return cell
    }

    @objc private func stepperValueChanged(_ sender: UIStepper) {
        itemCount = Int(sender.value)
        tableView.reloadData() // Reload the table to reflect the updated count
    }
    
    @objc private func addToBasketButtonTapped() {
        // Handle adding the item to the basket
        let product = ProductDetails(productName: itemTitle ?? "", description: itemDescription ?? "", price: itemPrice ?? 0.0, imageName: itemImage ?? "")
        
        // Add to basket
        BasketManager.shared.addProductToBasket(product)
        
    }
}



class ItemDetailTableViewCell: UITableViewCell {
    
    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let itemDescriptionLabel = UILabel()
    let itemPriceLabel = UILabel()
    
    let quantityStepper = UIStepper()
    let quantityLabel = UILabel()
    
    let addToBasketButton = UIButton()
    
    private let spacerView = UIView() // Spacer between stepper and button

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Item Image View Setup
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.contentMode = .scaleAspectFill
        contentView.addSubview(itemImageView)
        
        // Item Name Label Setup
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        itemNameLabel.numberOfLines = 1
        contentView.addSubview(itemNameLabel)
        
        // Item Description Label Setup
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        itemDescriptionLabel.numberOfLines = 0
        contentView.addSubview(itemDescriptionLabel)
        
        // Item Price Label Setup
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        itemPriceLabel.textColor = .green
        contentView.addSubview(itemPriceLabel)
        
        // Quantity Stepper Setup
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        quantityStepper.minimumValue = 1
        quantityStepper.stepValue = 1
        quantityStepper.addTarget(self, action: #selector(quantityChanged), for: .valueChanged)
        contentView.addSubview(quantityStepper)
        
        // Quantity Label Setup (centered between the minus and plus buttons)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.textAlignment = .center
        quantityLabel.text = "\(Int(quantityStepper.value))"
        contentView.addSubview(quantityLabel)
        
        // Add to Basket Button Setup
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        addToBasketButton.setTitle("Add to Basket", for: .normal)
        addToBasketButton.setTitleColor(.blue, for: .normal)
        addToBasketButton.backgroundColor = .clear
        addToBasketButton.layer.borderWidth = 1
        addToBasketButton.layer.borderColor = UIColor.blue.cgColor
        addToBasketButton.layer.cornerRadius = 6
        addToBasketButton.addTarget(self, action: #selector(addToBasketTapped), for: .touchUpInside)
        contentView.addSubview(addToBasketButton)
        
        // Spacer between Stepper and Add to Basket Button
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(spacerView)
        
        // Constraints Setup
        let padding: CGFloat = 10
        let buttonSpacing: CGFloat = 15 // Space between the stepper and button
        let verticalOffset: CGFloat = 20 // Vertical offset to move stepper and button down

        NSLayoutConstraint.activate([
            // Item Image
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Item Name Label
            itemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: padding),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // Item Description Label
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 5),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: padding),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // Item Price Label
            itemPriceLabel.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: 5),
            itemPriceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: padding),
            itemPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            // Quantity Stepper Setup (Moved down by verticalOffset)
            quantityStepper.topAnchor.constraint(equalTo: itemPriceLabel.bottomAnchor, constant: verticalOffset),
            quantityStepper.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: padding),
            quantityStepper.widthAnchor.constraint(equalToConstant: 80),
            quantityStepper.heightAnchor.constraint(equalToConstant: 30),
            
            // Quantity Label Setup (centered between minus and plus buttons)
            quantityLabel.centerYAnchor.constraint(equalTo: quantityStepper.centerYAnchor),
            quantityLabel.centerXAnchor.constraint(equalTo: quantityStepper.centerXAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 40),
            
            // Spacer between Stepper and Add to Basket Button
            spacerView.leadingAnchor.constraint(equalTo: quantityStepper.trailingAnchor, constant: padding),
            spacerView.trailingAnchor.constraint(equalTo: addToBasketButton.leadingAnchor, constant: -padding),
            spacerView.centerYAnchor.constraint(equalTo: quantityStepper.centerYAnchor),
            spacerView.heightAnchor.constraint(equalToConstant: 1), // This is a flexible spacer

            // Add to Basket Button Setup (Moved down with the stepper)
            addToBasketButton.topAnchor.constraint(equalTo: quantityStepper.topAnchor),
            addToBasketButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            addToBasketButton.widthAnchor.constraint(equalToConstant: 120),  // Reduced width
            addToBasketButton.heightAnchor.constraint(equalToConstant: 40)   // Reduced height
        ])
    }

    // Configure the cell with product details
    func configure(with product: ProductDetails) {
        itemImageView.image = UIImage(named: product.imageName)
        itemNameLabel.text = product.productName
        itemDescriptionLabel.text = product.description
        itemPriceLabel.text = "$\(product.price)"
    }
    
    @objc private func quantityChanged() {
        // Update the quantity label when the stepper value changes
        quantityLabel.text = "\(Int(quantityStepper.value))"
    }

    @objc private func addToBasketTapped() {
        // Handle the "Add to Basket" button action here
        print("Product added to basket.")
    }
}



