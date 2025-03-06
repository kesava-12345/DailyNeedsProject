import UIKit

class UserDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var userDetails = [
        ["username": "John Abraham", "mobile": "9876534567", "email": "johndoe@example.com"]
    ]

    let options = [
        ("Orders", "cart"),
        ("Address", "location"),
        ("Wallet", "wallet"),
        ("Saved Payments", "creditcard"),
        ("Ratings & Reviews", "star"),
        ("Support", "questionmark.circle"),
        ("Gift Cards", "gift"),
        ("Notifications", "bell"),
        ("Terms & Conditions", "doc.plaintext")
    ]
    let logoutOption = "Logout"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the navigation bar
        self.title = "My Account"

        // Customize the back button
        setupBackButton()

        // Setup Table View
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.register(OptionTableViewCell.self, forCellReuseIdentifier: "OptionTableViewCell")
        view.addSubview(tableView)

        // Table View Constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    

    // Customize back button with an arrow
    private func setupBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    // Back button action
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // Table View DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // First section is the profile, second section is the options
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return userDetails.count
        } else {
            return options.count + 1 // Options and logout
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            let user = userDetails[indexPath.row]
            
            // Set the profile image
            cell.profileImageView.image = UIImage(named: "profile_placeholder") // Placeholder image
            cell.usernameLabel.text = user["username"]
            cell.mobileNumberLabel.text = user["mobile"]
            cell.emailLabel.text = user["email"]
            
            // Handle Edit button (pencil) tap
            cell.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
            
            if indexPath.row == options.count {
                // Last row is Logout
                cell.iconImageView.image = UIImage(systemName: "power")
                cell.optionLabel.text = logoutOption
                cell.optionLabel.textColor = .red
            } else {
                let option = options[indexPath.row]
                cell.iconImageView.image = UIImage(systemName: option.1) // Use system images
                cell.optionLabel.text = option.0
                cell.optionLabel.textColor = .black
            }
            
            return cell
        }
    }

    // Adjust row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 60
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {

            print("Profile section tapped")
        } else {
            if indexPath.row == options.count {
                logout()
            } else {

                let selectedOption = options[indexPath.row].0
                print("Selected: \(selectedOption)")
            }
        }
    }

    func logout() {
        print("User logged out")
        

    }

    @objc func editButtonTapped() {
        print("Edit button tapped")

        let editVC = EditUserDetailsViewController()
        editVC.view.backgroundColor = .white
        navigationController?.pushViewController(editVC, animated: true)
    }
}


import UIKit

class ProfileTableViewCell: UITableViewCell {

    var profileImageView: UIImageView!
    var usernameLabel: UILabel!
    var mobileNumberLabel: UILabel!
    var emailLabel: UILabel!
    var editButton: UIButton!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        // Set the background color of the cell
        contentView.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        
        // Profile Image
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .lightGray 
        contentView.addSubview(profileImageView)

        // Username label
        usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(usernameLabel)

        // Mobile number label
        mobileNumberLabel = UILabel()
        mobileNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        mobileNumberLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(mobileNumberLabel)

        // Email label
        emailLabel = UILabel()
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .darkGray
        contentView.addSubview(emailLabel)

        // Edit button (pencil symbol)
        editButton = UIButton(type: .system)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        contentView.addSubview(editButton)
        
        // Set up the constraints
        NSLayoutConstraint.activate([
            // Profile Image
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),

            // Username Label
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            // Mobile Number Label
            mobileNumberLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            mobileNumberLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            
            // Email Label
            emailLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            emailLabel.topAnchor.constraint(equalTo: mobileNumberLabel.bottomAnchor, constant: 8),

            // Edit Button
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            editButton.widthAnchor.constraint(equalToConstant: 24),
            editButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

import UIKit

class EditUserDetailsViewController: UIViewController {

    var usernameTextField: UITextField!
    var mobileTextField: UITextField!
    var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Edit Details"
        
        // Setup UI for editing details
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    func setupUI() {
        // Username Text Field
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Enter username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        // Mobile Text Field
        mobileTextField = UITextField()
        mobileTextField.placeholder = "Enter mobile number"
        mobileTextField.borderStyle = .roundedRect
        mobileTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mobileTextField)
        
        // Email Text Field
        emailTextField = UITextField()
        emailTextField.placeholder = "Enter email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        // Constraints
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            mobileTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            mobileTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mobileTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emailTextField.topAnchor.constraint(equalTo: mobileTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}


import UIKit

class OptionTableViewCell: UITableViewCell {
    
    // UI Elements
    var iconImageView: UIImageView!
    var optionLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    func setupUI() {
        // Set the background color of the cell
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2) // Set a light gray background for the cell
        
        // Icon Image View
        iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        contentView.addSubview(iconImageView)

        // Option Label
        optionLabel = UILabel()
        optionLabel.translatesAutoresizingMaskIntoConstraints = false
        optionLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(optionLabel)

        // Set up the constraints
        NSLayoutConstraint.activate([
            // Icon Image View
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            // Option Label
            optionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
