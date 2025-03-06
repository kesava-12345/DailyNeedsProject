//
//  CategoryCollectionViewCell.swift
//  DailyNeedsProject
//
//  Created by apple on 14/11/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private var nameLabel: UILabel!
    private var categoryImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        categoryImageView = UIImageView()
        categoryImageView.contentMode = .scaleAspectFill
        categoryImageView.layer.cornerRadius = 8
        categoryImageView.clipsToBounds = true
        contentView.addSubview(categoryImageView)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with name: String, image: UIImage) {
        nameLabel.text = name
        categoryImageView.image = image
    }
}
