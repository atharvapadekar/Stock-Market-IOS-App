//
//  HomeVC.swift
//  pracccc
//
//  Created by Atharva Padekar on 07/08/23.
//

import UIKit
import Charts

class CompanyInfoVC: UIViewController {
    var sti = [StockInfo]()
    var abc = [Double]()
    var overView = [Overview]()
    var symbolC: String = ""
    
    let loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    let nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 18)
            //label.textAlignment = .center
            //label.numberOfLines = 0
            return label
        }()

        let symbolLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 16)
            //label.textAlignment = .center
            return label
        }()

        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 14)
            //label.textAlignment = .center
            label.numberOfLines = 0
            return label
        }()
    
    let assetTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        //label.textAlignment = .center
        return label
    }()
    
    let exchangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        //label.textAlignment = .center
        return label
    }()
    
    let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        //label.textAlignment = .center
        return label
    }()
    
    let profitMarginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.systemGreen
        //label.textAlignment = .center
        return label
    }()

    let lineChartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfo()
        getOV()
        view.addSubview(loadingView) // Add the loading view to your view hierarchy
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .systemBackground
    }
    
    private func getInfo() {
        APICaller.shared.getData(for: symbolC) { results in
            switch results {
            case.success(let info):
                self.sti.append(info)
                //print(self.sti[0].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.open ?? "a")
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                                self.chartConfig() // Call chartConfig on the main thread
                    
                            }
            case.failure(let error):
                print("info data: \(error)")
                
            }
            
        }
    }
    
    private func getOV() {
        APICaller.shared.getOverview(for: symbolC) { results in
            switch results {
            case.success(let ov):
                self.overView.append(ov)
                DispatchQueue.main.async {
//                    self.loadingView.removeFromSuperview()
                    self.setupUI()
                }
            case.failure(let error):
                print("info OV: \(error)")
            }
        }
    }
    
    private func setupUI() {
        nameLabel.text = overView[0].name
        symbolLabel.text = "Symbol: \(overView[0].symbol)"
        descriptionLabel.text = overView[0].description
        assetTypeLabel.text = "Asset Type: \(overView[0].assetType)"
        exchangeLabel.text = "Exchange: \(overView[0].exchange)"
        currencyLabel.text = "Currency: \(overView[0].currency)"
        profitMarginLabel.text = "Profit MArgin: \(overView[0].profitMargin)"
    }
    
    func chartConfig() {
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
//        var ans = Double(self.sti[0].monthlyTimeSeries.sorted(by: { $1.key > $0.key }).last?.value.open ?? "0.0")
//        abc.append((ans ?? 0.0))
        
        let monthlyTimeSeries = self.sti[0].monthlyTimeSeries.sorted(by: { $1.key > $0.key })
        for i in 0..<min(5, monthlyTimeSeries.count) {
            let value = monthlyTimeSeries[monthlyTimeSeries.index(monthlyTimeSeries.endIndex, offsetBy: -(i + 1))].value.open
            let convertedValue = Double(value ) ?? 0.0
            abc.append(convertedValue)
        }
        
        let dataEntries: [ChartDataEntry] = [
                    ChartDataEntry(x: 0, y: abc[4]),
                    ChartDataEntry(x: 1, y: abc[3]),
            ChartDataEntry(x: 2, y: abc[2]),
            ChartDataEntry(x: 3, y: abc[1]),
            ChartDataEntry(x: 4, y: abc[0])
        ]
        let chartFont = UIFont.systemFont(ofSize: 12)
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Line Chart")
        dataSet.colors = [UIColor.green]
        dataSet.circleColors = [UIColor.red]
        dataSet.valueFont = chartFont
        let data = LineChartData(dataSet: dataSet)
        lineChartView.data = data
        
        let xAxis = lineChartView.xAxis
        xAxis.labelFont = chartFont
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = false
        
        let padding:Double = 0.5
        let minXValue: Double = -padding // Adjust the minimum x value with padding
        let maxXValue: Double = Double(dataEntries.count) - 1.0 + padding // Adjust the maximum x value with padding
        xAxis.axisMinimum = minXValue
        xAxis.axisMaximum = maxXValue
        
        let leftAxis = lineChartView.leftAxis
        let maxValue = abc.max() ?? 0.0
        let bufferPercentage: Double = 0.1 // Adjust the buffer percentage as needed
        let bufferValue = maxValue * bufferPercentage
            
        leftAxis.axisMaximum = maxValue + bufferValue
        leftAxis.drawLabelsEnabled = false
        
        let rightAxis = lineChartView.rightAxis
        rightAxis.drawLabelsEnabled = false

                // Refresh the chart
        lineChartView.notifyDataSetChanged()
        
       
        
        
        
        
        self.view.addSubview(self.lineChartView)
        view.addSubview(nameLabel)
        view.addSubview(symbolLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(assetTypeLabel)
        view.addSubview(exchangeLabel)
        view.addSubview(currencyLabel)
        view.addSubview(profitMarginLabel)
        
        
        NSLayoutConstraint.activate([
            self.lineChartView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.lineChartView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            self.lineChartView.heightAnchor.constraint(equalToConstant: 200),
            self.lineChartView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            symbolLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: profitMarginLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            assetTypeLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10),
            assetTypeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            exchangeLabel.topAnchor.constraint(equalTo: assetTypeLabel.bottomAnchor, constant: 10),
            exchangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            
            currencyLabel.topAnchor.constraint(equalTo: exchangeLabel.bottomAnchor, constant: 10),
            currencyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            profitMarginLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 10),
            profitMarginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    

    func configure(with symbol: String){
        symbolC = symbol
    }
}

//class XAxisFormatter: AxisValueFormatter {
//    let months = ["Jan", "Feb", "Mar", "Apr", "May"]
//
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        // Use value to determine the index of the month
//        let index = Int(value)
//        return months[index % months.count]
//    }
//}

