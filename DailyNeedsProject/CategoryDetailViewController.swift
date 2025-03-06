//
//  CategoryDetailViewController.swift
//  DailyNeedsProject
//
//  Created by apple on 14/11/24.
//

import UIKit

class CategoryDetailViewController: UIViewController {
    
    private var category: Category // Make sure this matches the Category struct
    private var tableView: UITableView!
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = category.name
        
        tableView = UITableView()
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension CategoryDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.relatedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = category.relatedProducts[indexPath.row] // Access relatedProducts correctly
        return cell
    }
}
