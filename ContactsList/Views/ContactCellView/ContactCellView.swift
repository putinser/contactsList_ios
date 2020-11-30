import UIKit

class ContactCellView: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
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
        nameLabel.text = contact.name ?? "Имя не указано"
        
        if let mainPhone = contact.mainPhone {
            phoneLabel.text = mainPhone
        } else {
            if contact.phones.count != 0 {
                phoneLabel.text = contact.phones.first
            } else {
                phoneLabel.text = "Номер телефона отсутствует"
            }
        }

        if let imageThumbnail = contact.imageThumbnail {
            photoImage.image = imageThumbnail
        } else {
            photoImage.image = UIImage(named: "ic_placeholder_no_user")
        }
    }
    
}
