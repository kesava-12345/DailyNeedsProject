import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarVC = UITabBarController()
        
        // Create view controllers for each tab
        let dailyNeeds = UINavigationController(rootViewController: DailyNeedsViewController())
        let categories = UINavigationController(rootViewController: CategoriesViewController())
        let userDeals = UINavigationController(rootViewController: UserDealsViewController())
        let basket = UINavigationController(rootViewController: BasketViewController())

        // Set titles for each tab
        dailyNeeds.title = "Daily Needs"
        categories.title = "Categories"
        userDeals.title = "User Deals"
        basket.title = "Basket"
        
        // Set the view controllers for the tab bar
        tabBarVC.setViewControllers([dailyNeeds, categories, userDeals, basket], animated: false)
        
        // Set the icons for each tab
        guard let items = tabBarVC.tabBar.items else { return }
        let images = ["house", "list.bullet", "tag", "cart.fill"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        
                tabBarVC.tabBar.backgroundColor = UIColor.white  // Set background color of the tab bar
                tabBarVC.tabBar.tintColor = UIColor.blue  // Set the selected tab icon and text color
                tabBarVC.tabBar.unselectedItemTintColor = UIColor.lightGray
        
        // Add the tab bar controller as a child view controller
        addChild(tabBarVC)
        
        // Set the frame of the tab bar view
        tabBarVC.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
        // Add the tab bar view to the main view
        view.addSubview(tabBarVC.view)
    }
}












