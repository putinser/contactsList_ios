import UIKit

class InfoUserCellView: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        configureUI()
    }
    
    func configureUI() {
        photoImage.layer.cornerRadius = photoImage.frame.height / 2
        photoImage.layer.masksToBounds = true
    }
    
    func configureCell(contact: Contact) {
        nameLabel.text = contact.name
        
        if let image = contact.image {
            photoImage.image = image
        } else {
            photoImage.image = UIImage(named: "ic_placeholder_no_user")
        }
    }
    
}
