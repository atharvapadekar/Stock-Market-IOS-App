//
//  HomeVC.swift
//  College Website
//
//  Created by Atharva Padekar on 01/08/23.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate {
    
    
    
    var stockInformation = [StockInfo]()
    
    let stockSymbols:[String] =  ["AAPL", "WMT", "MSFT", "GOOG", "AMZN"]
    
    let stockCompanies:[String] = ["Apple Inc. Common Stock", "Walmart Inc. Common Stock", "Microsoft Corporation Common Stock", "Alphabet Inc. Class C Capital Stock", "Amazon.com, Inc. Common Stock"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView()  //frame: .zero, style: .grouped
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table


    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "American Stock Exchange"
        configureNavbar()
        updateTableViewData()
        view.backgroundColor = .systemBackground
        //homeFeedTable.backgroundColor = .systemBackground
        
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self

        // Do any additional setup after loading the view.
        
        view.addSubview(homeFeedTable)
        homeFeedTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        homeFeedTable.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame =  view.bounds

    }
    
    
    func updateTableViewData() {
        
        for i in 0..<5 {
            DispatchQueue.global().asyncAfter(deadline: .now() + Double(i) * 2) {
                APICaller.shared.getResult(for: self.stockSymbols[i]) { result in
                        switch result {
                        case .success(let stockINFO):
                            self.stockInformation.append(stockINFO)
                            print(self.stockInformation[i].metaData.symbol)
                            if self.stockInformation.count == self.stockSymbols.count {
                                // All data is fetched, reload the table view
                                DispatchQueue.main.async {
                                    self.homeFeedTable.reloadData()
                                }
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
            
                }
        }
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
        
        //navigationItem.title = "American Stock Exchange"
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
                        .foregroundColor: UIColor.white, // Replace with your desired color
            .font: UIFont.systemFont(ofSize: 13, weight: .thin) // Replace with your desired font and size
                    ]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//            navigationItem.leftBarButtonItems = [flexibleSpace]
    }
    
}

extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stockCompanies.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        configureCell(cell, at: indexPath)
        
        
        return cell
    }
    
    func configureCell(_ cell: CollectionViewTableViewCell, at indexPath: IndexPath) {
        let title = stockCompanies[indexPath.section]
        let symbol = stockSymbols[indexPath.section]
        let open = "Loading..."
        let high = "Loading..."
        let volume = "Loading..."
        let scene = "Loading..."
        
        cell.titleLabel.text = title
        cell.symbolLabel.text = symbol
        cell.openLabel.text = open
        cell.highLabel.text = high
        cell.volumeLabel.text = volume
        cell.sceneLabel.text = scene
        cell.statusLabel.text = ""  // Clear the status label
        
        updateCellWithActualData(cell, at: indexPath)
    }
    
    func updateCellWithActualData(_ cell: CollectionViewTableViewCell, at indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) { [weak self] in
                   guard let strongSelf = self else { return }
                   
                   let section = indexPath.section // Get the section
                   
                   if section < strongSelf.stockInformation.count {
                       let actualOpen = strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.open ?? "a"
                       let actualHigh = strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.high ?? "a"
                       let actualVolume = strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.volume ?? "a"
                       
                       let lastOpen = Double(strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.open ?? "a")
                       let secondLastOpen = Double(strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).dropLast().last?.value.open ?? "a")
                       
                       let ans = (lastOpen ?? 0.0) - (secondLastOpen ?? 0.0)
                       let ansstr = String(format: "%.2f", ans)
                       var finalstr = ""
                       
                       if (lastOpen ?? 0.0) < (secondLastOpen ?? 0.0) {
                           cell.sceneLabel.textColor = .red
                           cell.statusLabel.textColor = .red
                           cell.statusLabel.text = "↓"
                           finalstr = "\(ansstr) $"
                       } else if (lastOpen ?? 0.0) > (secondLastOpen ?? 0.0) {
                           cell.sceneLabel.textColor = .green
                           cell.statusLabel.textColor = .green
                           cell.statusLabel.text = "↑"
                           finalstr = "+\(ansstr) $"
                       } else {
                           cell.sceneLabel.textColor = .white
                       }
                       
                       cell.openLabel.text = "Open: $\(actualOpen)"
                       cell.highLabel.text = "High: $\(actualHigh)"
                       cell.volumeLabel.text = "Volume: \(actualVolume)"
                       cell.sceneLabel.text = finalstr
                   }
               }
        
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = .clear
            return headerView
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let symbol = stockSymbols[indexPath.section]
        DispatchQueue.main.async {
            let vc = CompanyInfoVC()
            vc.configure(with: symbol)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// ↓ ↑

//let stockSymbols:[String] =  ["AAPL", "WMT", "MSFT", "GOOG", "AMZN", "NVDA", "TSLA", "META", "JPM", "TSM"]
//
//let stockCompanies:[String] = ["Apple Inc. Common Stock", "Walmart Inc. Common Stock", "Microsoft Corporation Common Stock", "Alphabet Inc. Class C Capital Stock", "Amazon.com, Inc. Common Stock", "NVIDIA Corporation Common Stock", "Tesla, Inc. Common Stock", "Meta Platforms, Inc. Class A Common Stock", "Berkshire Hathaway Inc."]


//var image = UIImage(named: "appLogo")
//image = image?.withRenderingMode(.alwaysOriginal)
//navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
//
//navigationItem.rightBarButtonItems = [
//    UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
//    UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
//]
//navigationController?.navigationBar.tintColor = .gray


//if section < strongSelf.stockInformation.count {
//    let actualOpen = strongSelf.stockInformation[indexPath.section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.open ?? "a"
//    let actualHigh = strongSelf.stockInformation[indexPath.section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.high ?? "a"
//    let actualVolume = strongSelf.stockInformation[indexPath.section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.volume ?? "a"
//
//                    let lastOpen = Double(strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.open ?? "a")
//                    let secondLastOpen = Double(strongSelf.stockInformation[section].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).dropLast().last?.value.open ?? "a")
//
//                    let ans = (lastOpen ?? 0.0) - (secondLastOpen ?? 0.0)
//                    let ansstr = String(format: "%.2f", ans)
//                    var finalstr = ""
//
//                    if (lastOpen ?? 0.0) < (secondLastOpen ?? 0.0) {
//                        cell.sceneLabel.textColor = .red
//                        cell.statusLabel.textColor = .red
//                        cell.statusLabel.text = "↓"
//                        finalstr = "\(ansstr) $"
//                    } else if (lastOpen ?? 0.0) > (secondLastOpen ?? 0.0) {
//                        cell.sceneLabel.textColor = .green
//                        cell.statusLabel.textColor = .green
//                        cell.statusLabel.text = "↑"
//                        finalstr = "+\(ansstr) $"
//                    } else {
//                        cell.sceneLabel.textColor = .white
//                    }
//
//                    cell.openLabel.text = "Open: $\(actualOpen)"
//                    cell.highLabel.text = "High: $\(actualHigh)"
//                    cell.volumeLabel.text = "Volume: \(actualVolume)"
//                    cell.sceneLabel.text = finalstr
//
//
//}
