
import UIKit
import ContactsUI

class ListContactsViewController: UIViewController {
    
    static unowned var storyboardInstance: ListContactsViewController {
        return UIStoryboard(name: "ListContacts", bundle: nil).instantiateInitialViewController() as! ListContactsViewController
    }
    
    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = [Contact]()
    var refreshControl = UIRefreshControl()

    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    //MARK: - Methods
    
    private func initialSetup() {
        cellRegister()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.tableFooterView = UIView()

        setupNavigationItems()
        getContactFromCNContact()
        
        setupRefreshControl()
    }
    
    private func cellRegister() {
        tableView.register(UINib(nibName: "ContactCellView", bundle: nil), forCellReuseIdentifier: "ContactCellView")
    }
    
    func getContactFromCNContact() {
        
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
        case .authorized:
            loadContacts()
        case .notDetermined:
            let contactStore = CNContactStore()
            contactStore.requestAccess(for: .contacts) { (succes, error) in
                if succes {
                    self.loadContacts()
                }
            }
        case .denied:
            self.showOpenSettingsAlert(error: "Для прсмотра списка контактов нужно в настройках приложения разрешить доступ к контатам.")
        default:
            return
        }
    }
    
    
    private func loadContacts() {
        contacts.removeAll()
        let contactStore = CNContactStore()
        
        let keys = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactImageDataKey, CNContactThumbnailImageDataKey
            ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                
                var phones = [String]()
                var mainPhone: String? = nil
                var name: String? = nil
                
                for item in contact.phoneNumbers {
                    if let label = item.label {
                        if label == "_$!<Main>!$_" {mainPhone = item.value.stringValue}
                    }
                    phones.append(item.value.stringValue)
                }
                
                if !contact.givenName.isEmpty, !contact.familyName.isEmpty {
                    name = "\(contact.givenName) \(contact.familyName)"
                }
                
                let value = Contact(name: name, imageDate: contact.imageData, imageThumbnailDate: contact.thumbnailImageData, mainPhone: mainPhone, phones: phones)
                self.contacts.append(value)
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
            
        } catch {
            print("Не удалось получить контакты")
        }
    }
    
    private func showOpenSettingsAlert(error: String){
        let allertView = UIAlertController(title: "Внимание!", message: error, preferredStyle: .alert)
        if let presenter = allertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        
        allertView.addAction(UIAlertAction(title: "Открыть настройки", style: .default, handler: { (action:UIAlertAction) in
            self.refreshControl.endRefreshing()
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        
        allertView.addAction(UIAlertAction.init(title: "Позже", style: .default, handler: { (action:UIAlertAction) in
            self.refreshControl.endRefreshing()
        }))
        
        self.present(allertView, animated: true, completion: nil)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Список контактов"
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    //MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
       getContactFromCNContact()
    }
    
    //MARK: - IBActions
    
}

//MARK: - Extensions

extension ListContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCellView") as! ContactCellView
        cell.configureCell(contact: contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let control = ContactViewController.storyboardInstance
        control.contact = contacts[indexPath.row]
        navigationController?.pushViewController(control, animated: true)
    }
}
