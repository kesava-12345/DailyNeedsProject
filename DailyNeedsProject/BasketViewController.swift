import UIKit

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tableView: UITableView!
    var basketItems: [ProductDetails] = []
    
    private var buyNowButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBuyNowButton()
        basketItems = BasketManager.shared.getBasketItems()

        // Listen for notifications when the basket is updated
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBasketItems), name: .basketUpdated, object: nil)
        
        // Update button visibility when the view loads
        updateBuyNowButtonVisibility()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        view.addSubview(tableView)
    }
    
    private func setupBuyNowButton() {
        // Initialize Buy Now button
        buyNowButton = UIButton(type: .system)
        buyNowButton.setTitle("Buy Now", for: .normal)
        buyNowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        buyNowButton.backgroundColor = .systemBlue
        buyNowButton.tintColor = .white
        buyNowButton.layer.cornerRadius = 10
        buyNowButton.addTarget(self, action: #selector(buyNowTapped), for: .touchUpInside)

        // Add button to view
        view.addSubview(buyNowButton)

        // Set up Auto Layout constraints to make the button span the full width and be at the bottom
        buyNowButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyNowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buyNowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buyNowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            buyNowButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // Initially hide the Buy Now button
        buyNowButton.isHidden = true
    }

    // TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = basketItems[indexPath.row]
        cell.configure(with: product)

        // Check if the product is already in the basket and hide the "Add to Basket" button accordingly
        let isProductInBasket = BasketManager.shared.getBasketItems().contains { $0.productName == product.productName }
        cell.addToBasketButton.isHidden = isProductInBasket

        return cell
    }

    // Method to reload basket items when an item is added
    @objc func reloadBasketItems() {
        basketItems = BasketManager.shared.getBasketItems()
        tableView.reloadData()

        // Update visibility of the "Buy Now" button after the basket items have been reloaded
        updateBuyNowButtonVisibility()
        
        // Optionally, hide the "Add to Basket" button for products already in the basket
        for (index, product) in basketItems.enumerated() {
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ProductTableViewCell {
                let isProductInBasket = BasketManager.shared.getBasketItems().contains { $0.productName == product.productName }
                cell.addToBasketButton.isHidden = isProductInBasket
            }
        }
    }
    
    // Method to show/hide the "Buy Now" button based on basket contents
    private func updateBuyNowButtonVisibility() {
        // If there are items in the basket, show the "Buy Now" button
        buyNowButton.isHidden = basketItems.isEmpty
    }

    // Buy Now button action
    @objc func buyNowTapped() {
        // Handle the Buy Now functionality here
        print("Buy Now tapped! Proceeding with checkout.")
        // You can navigate to a checkout screen or process the order here.
    }
}

extension Notification.Name {
    static let basketUpdated = Notification.Name("basketUpdated")
}
 
