import UIKit

class UserDealsViewController: UIViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar?
    var orderNowButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the view controller
        title = "User Deals"
        
        // Customize the left bar button (arrow icon)
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"), // System arrow symbol
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        // Customize the right bar button (search icon)
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"), // System search symbol
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped)
        )
        navigationItem.rightBarButtonItem = searchButton
        
        // Create and add the "Order Now" button in the center of the screen
        orderNowButton = UIButton(type: .system)
        orderNowButton.setTitle("Order Now...", for: .normal)
        orderNowButton.addTarget(self, action: #selector(orderNowTapped), for: .touchUpInside)
        orderNowButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(orderNowButton)
        
        orderNowButton.backgroundColor = UIColor.lightGray
              
              // Set the title color to white for contrast
              orderNowButton.setTitleColor(UIColor.white, for: .normal)
              
              // Round the corners of the button (optional)
              orderNowButton.layer.cornerRadius = 10
        
        // Center the "Order Now" button in the middle of the view
        NSLayoutConstraint.activate([
            orderNowButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderNowButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            orderNowButton.widthAnchor.constraint(equalToConstant: 200),  // Optional: Set width
            orderNowButton.heightAnchor.constraint(equalToConstant: 50)   // Optional: Set height
        ])
    }
    
    // Action when the back button is tapped
    @objc func backButtonTapped() {
        // Perform the back navigation
        navigationController?.popViewController(animated: true)
    }
    
    // Action when the search button is tapped
    @objc func searchButtonTapped() {
        // Create the search bar if it doesn't already exist
        if searchBar == nil {
            searchBar = UISearchBar()
            searchBar?.delegate = self
            searchBar?.placeholder = "Search Deals"
            searchBar?.sizeToFit()
            searchBar?.autocapitalizationType = .none
        }
        
        // Set the search bar as the title view of the navigation bar
        navigationItem.titleView = searchBar
        
        // Optionally, focus on the search bar when it appears
        searchBar?.becomeFirstResponder()
        
        // Change the search button to a cancel button after the search is initiated
        let cancelButton = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    // Action when the cancel button is tapped
    @objc func cancelButtonTapped() {
        // Dismiss the search bar and restore the left button
        navigationItem.titleView = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        // Resign the search bar's first responder status
        searchBar?.resignFirstResponder()
    }
    
    // UISearchBarDelegate method to handle the search input
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Perform the search operation based on searchText
        print("Searching for: \(searchText)")
    }
    
    @objc func orderNowTapped() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
    }
}
