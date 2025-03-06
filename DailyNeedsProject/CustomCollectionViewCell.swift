import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
      
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 70))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
     
        titleLabel = UILabel(frame: CGRect(x: 5, y: frame.height - 60, width: frame.width - 10, height: 40))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 8)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
//        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.layer.masksToBounds = true
//        titleLabel.adjustsFontSizeToFitWidth = false
        contentView.addSubview(titleLabel)
        
  
        descriptionLabel = UILabel(frame: CGRect(x: 5, y: frame.height - 30, width: frame.width - 10, height: 20))
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 1
        descriptionLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(descriptionLabel)
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
