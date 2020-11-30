import UIKit

class ContactViewController: UIViewController {
    
    static unowned var storyboardInstance: ContactViewController {
        return UIStoryboard(name: "Contact", bundle: nil).instantiateInitialViewController() as! ContactViewController
    }

    //MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var contact = Contact()
    
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
    }
    
    private func cellRegister() {
        tableView.register(UINib(nibName: "InfoUserCellView", bundle: nil), forCellReuseIdentifier: "InfoUserCellView")
        tableView.register(UINib(nibName: "PhoneCellView", bundle: nil), forCellReuseIdentifier: "PhoneCellView")
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Контакт"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(actionBack))
    }
    
    //MARK: - Actions
    
    @objc private func actionBack() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - IBActions
    
}

//MARK: - Extensions

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.phones.count + 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoUserCellView") as! InfoUserCellView
            cell.configureCell(contact: contact)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCellView") as! PhoneCellView
            cell.configureCell(phone: contact.phones[indexPath.row - 1])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
