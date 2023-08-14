//
//  SearchVC.swift
//  College Website
//
//  Created by Atharva Padekar on 02/08/23.
//



import UIKit

class SearchVC: UIViewController {
    
    var searchResponse: StockSearchResult?
    
        // ... Rest of your code ...
    
    private let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search"
            return searchBar
        }()
    
    private let tableView: UITableView = {
            let tableView = UITableView()
        tableView.register(SearchResponseTableViewCell.self, forCellReuseIdentifier: SearchResponseTableViewCell.identifier)
            return tableView
        }()
        
    private var searchResults: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "American Stock Exchange"
        configureNavbar()
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupKeyboardNotifications()
        

    }
    
    private func setupUI() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
            tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    private func configureNavbar() {
        
        let titleLabel = UILabel()
           titleLabel.text = "American Stock Exchange"
           titleLabel.textColor = .white
           titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .thin) // Customize the font and size
           titleLabel.sizeToFit()
        
        var image = UIImage(named: "appLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            //UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .gray
        navigationItem.titleView = titleLabel
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor: UIColor.white, // Replace with your desired color
            .font: UIFont.systemFont(ofSize: 13, weight: .thin) // Replace with your desired font and size
                    ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//            navigationItem.leftBarButtonItems = [flexibleSpace]
    }
    
    private func setupKeyboardNotifications() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc private func keyboardWillShow(notification: Notification) {
            tableView.contentInset.bottom = notification.keyboardFrameEnd.height
        }
        
        @objc private func keyboardWillHide(notification: Notification) {
            tableView.contentInset.bottom = 0
        }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let modifiedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
        if modifiedSearchText.count >= 3 {
            APICaller.shared.getSearchResults(for: modifiedSearchText) { results in
                switch results {
                case.success(let response):
                    self.searchResponse = response
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case.failure(let error):
                    print("Overview: \(error)")
                }
            }
        } else {
            searchResponse = nil
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder() // Dismiss the keyboard
            // Call your search API or other relevant actions here
        }

        
}

extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections based on your search results
        return searchResponse?.bestMatches.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in each section based on your search results
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure and return the cells based on your search results
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResponseTableViewCell.identifier, for: indexPath) as? SearchResponseTableViewCell,
                      let bestMatch = searchResponse?.bestMatches[indexPath.section] else {
                    return UITableViewCell()
                }
        
        cell.nameLabel.text = bestMatch.name
        cell.symbolLabel.text = bestMatch.symbol
        cell.currencyLabel.text = bestMatch.currency
        cell.typeLabel.text = bestMatch.type
        cell.regionLabel.text = bestMatch.region
        
            
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let symbol = self.searchResponse?.bestMatches[indexPath.section].symbol ?? ""
        DispatchQueue.main.async {
            let vc = CompanyInfoVC()
            vc.configure(with: symbol)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension Notification {
    var keyboardFrameEnd: CGRect {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect.zero
    }
}

