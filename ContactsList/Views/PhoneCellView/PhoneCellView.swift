import UIKit

class PhoneCellView: UITableViewCell {

    @IBOutlet weak var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
  
    func configureCell(phone: String) {
        phoneLabel.text = phone
    }
    
}
