import Foundation
import UIKit

struct Contact {
    var name: String?
    var image: UIImage?
    var imageThumbnail: UIImage?
    var mainPhone: String?
    var phones = [String]()
    
    init() {}
    
    init(name: String?, imageDate: Data? = nil, imageThumbnailDate: Data? = nil, mainPhone: String?, phones: [String]) {
        self.name = name
        self.phones = phones
        self.mainPhone = mainPhone
        if let imageDate = imageDate {
            self.image = UIImage(data: imageDate)
        }
        
        if let imageThumbnailDate = imageThumbnailDate {
            self.imageThumbnail = UIImage(data: imageThumbnailDate)
        }
    }
}
