import UIKit
class ProductDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var products: [ProductDetails] = []
    var categoryTitle: String?

    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupTableView()

        if let title = categoryTitle {
            self.title = title
        }

        setupNavigationBar()
        tableView.reloadData()
    }

    private func setupNavigationBar() {
        let basketIcon = UIImage(systemName: "cart.fill")
        let basketButton = UIBarButtonItem(image: basketIcon, style: .plain, target: self, action: #selector(didTapBasket))
        navigationItem.rightBarButtonItem = basketButton
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.rowHeight = 200
        view.addSubview(tableView)
    }

    @objc func didTapBasket() {
        if let tabBarController = tabBarController {
            tabBarController.selectedIndex = 3 // Assuming Basket tab is at index 3
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.configure(with: product)

        // Handle the "Add to Basket" action via closure
        cell.onAddToBasket = { [weak self] in
            self?.addToBasket(product)
        }

        return cell
    }

    // Method to add product to the basket
    func addToBasket(_ product: ProductDetails) {
        // Add the product with updated quantity to the BasketManager
        BasketManager.shared.addProductToBasket(product)
    }
}





class ProductTableViewCell: UITableViewCell {

    private let productImageView = UIImageView()
    private let textContainerView = UIView()
    private let productNameLabel = UILabel()
    private let productDescriptionLabel = UILabel()
    private let productPriceLabel = UILabel()

    private let quantityStepper = UIStepper()
    private let quantityLabel = UILabel()
     let addToBasketButton = UIButton()

    var onAddToBasket: (() -> Void)?

    private var product: ProductDetails?  // Store the product locally for updates

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
    private func setupUI() {
        // Image view setup - increased width to 100
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        contentView.addSubview(productImageView)
        
        // Text container setup
        textContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textContainerView)
        
        // Product Name Label setup - Increased font size
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.font = UIFont.boldSystemFont(ofSize: 18) // Increased size
        productNameLabel.numberOfLines = 0
        textContainerView.addSubview(productNameLabel)
        
        // Product Description Label setup - Increased font size
        productDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        productDescriptionLabel.font = UIFont.systemFont(ofSize: 16) // Increased size
        productDescriptionLabel.numberOfLines = 0
        productDescriptionLabel.textColor = .gray
        textContainerView.addSubview(productDescriptionLabel)
        
        // Product Price Label setup - Increased font size
        productPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        productPriceLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold) // Increased size
        productPriceLabel.textColor = .black
        textContainerView.addSubview(productPriceLabel)
        
        // Quantity Stepper setup
        quantityStepper.translatesAutoresizingMaskIntoConstraints = false
        quantityStepper.minimumValue = 1
        quantityStepper.maximumValue = 100
        quantityStepper.value = 1
        quantityStepper.addTarget(self, action: #selector(quantityChanged), for: .valueChanged)
        contentView.addSubview(quantityStepper)
        
        // Quantity Label setup (centered between the minus and plus buttons)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.text = "\(Int(quantityStepper.value))"
        quantityLabel.textAlignment = .center
        contentView.addSubview(quantityLabel)
        
        // Add to Basket button setup - increased height to 50
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        addToBasketButton.setTitle("Add to Basket", for: .normal)
        addToBasketButton.setTitleColor(.blue, for: .normal)
        addToBasketButton.backgroundColor = .clear
        addToBasketButton.layer.borderWidth = 1
        addToBasketButton.layer.borderColor = UIColor.blue.cgColor
        addToBasketButton.layer.cornerRadius = 8
        addToBasketButton.addTarget(self, action: #selector(addToBasketTapped), for: .touchUpInside)
        contentView.addSubview(addToBasketButton)

        // Constraints for image view and text container
        NSLayoutConstraint.activate([
            // Image view - increased width to 100
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            
            // Text container setup
            textContainerView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            textContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60), // Reserve space for the stepper and button
            
            // Product Name label
            productNameLabel.topAnchor.constraint(equalTo: textContainerView.topAnchor),
            productNameLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor),
            
            // Product Description label (increased space from productNameLabel)
            productDescriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8), // Increased space
            productDescriptionLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor),
            productDescriptionLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor),
            
            // Product Price label (increased space from productDescriptionLabel)
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 8), // Increased space
            productPriceLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor),
            productPriceLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor),
            
            // Quantity Stepper setup
            quantityStepper.topAnchor.constraint(equalTo: textContainerView.bottomAnchor, constant: 8),
            quantityStepper.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor),
            quantityStepper.widthAnchor.constraint(equalToConstant: 100),
            quantityStepper.heightAnchor.constraint(equalToConstant: 30),
            
            // Quantity Label setup
            quantityLabel.centerYAnchor.constraint(equalTo: quantityStepper.centerYAnchor),
            quantityLabel.centerXAnchor.constraint(equalTo: quantityStepper.centerXAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 40),
            
            // Add to Basket button setup (placed to the right of the stepper)
            addToBasketButton.topAnchor.constraint(equalTo: quantityStepper.topAnchor),
            addToBasketButton.leadingAnchor.constraint(equalTo: quantityStepper.trailingAnchor, constant: 12),
            addToBasketButton.widthAnchor.constraint(equalToConstant: 150),  // Set a fixed width for the button
            addToBasketButton.heightAnchor.constraint(equalToConstant: 50),
            addToBasketButton.bottomAnchor.constraint(equalTo: quantityStepper.bottomAnchor)
        ])
    }


    // Configuring the cell with product data
    func configure(with product: ProductDetails) {
        self.product = product
        productImageView.image = UIImage(named: product.imageName)
        productNameLabel.text = product.productName
        productDescriptionLabel.text = product.description
        productPriceLabel.text = "$\(product.price)"
        
        // Sync stepper and label with product's initial quantity
        quantityStepper.value = Double(product.quantity)
        quantityLabel.text = "\(product.quantity)"
    }

    // When the stepper value changes, update the quantity label
    @objc private func quantityChanged() {
        if var product = self.product {
            product.quantity = Int(quantityStepper.value)  // Update the quantity in the product model
            quantityLabel.text = "\(product.quantity)"  // Update the quantity label
        }
    }

    // When the "Add to Basket" button is tapped, notify parent controller to add the product
    @objc private func addToBasketTapped() {
        if let product = self.product {
            // Trigger the closure to add the updated product with the correct quantity to the basket
            onAddToBasket?()
            
        }
    }
}



class BasketManager {
    static let shared = BasketManager()

    private var basketItems: [ProductDetails] = []

    private init() {}

    // Add product to basket, and if it exists, update the quantity
    func addProductToBasket(_ product: ProductDetails) {
        if let existingProductIndex = basketItems.firstIndex(where: { $0.productName == product.productName }) {
            // Update the quantity if the product already exists in the basket
            basketItems[existingProductIndex].quantity += product.quantity
        } else {
            basketItems.append(product)
        }
    }

    func getBasketItems() -> [ProductDetails] {
        return basketItems
    }

    func removeProductFromBasket(_ product: ProductDetails) {
        if let index = basketItems.firstIndex(where: { $0.productName == product.productName }) {
            basketItems.remove(at: index)
        }
    }
}



