//
//  APICaller.swift
//  College Website
//
//  Created by Atharva Padekar on 01/08/23.
//

import Foundation
//import Firebase


struct Constants {
    static let API_KEY = "FGX1Q50YKM68392K"
    static let baseURL = "https://www.alphavantage.co/query?function="
}


enum APIError: Error {
    case failedTogetData
}

class APICaller{
    
    static let shared  = APICaller()
    
    
    func getResult(for symbol: String, completion: @escaping (Result<StockInfo, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)TIME_SERIES_MONTHLY&symbol=\(symbol)&apikey=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data,error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(StockInfo.self, from: data)
                completion(.success(results))
                //print(results)
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getOverview(for symbol: String, completion: @escaping (Result<Overview, Error>) -> Void) {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=OVERVIEW&symbol=\(symbol)&apikey=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data,error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Overview.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getData(for symbol: String, completion: @escaping (Result<StockInfo, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)TIME_SERIES_MONTHLY&symbol=\(symbol)&apikey=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data,error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(StockInfo.self, from: data)
                completion(.success(results))
                //print(results)
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getSearchResults(for symbol: String, completion: @escaping (Result<StockSearchResult, Error>) -> Void) {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(symbol)&apikey=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data,error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(StockSearchResult.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

}

// \(Constants.baseURL)TIME_SERIES_MONTHLY&symbol=IBM&apikey=\(Constants.API_KEY)

// EK555CK7D3WVHR2L

//{
//    "Meta Data": {
//        "1. Information": "Monthly Prices (open, high, low, close) and Volumes",
//        "2. Symbol": "AAPL",
//        "3. Last Refreshed": "2023-08-04",
//        "4. Time Zone": "US/Eastern"
//    },
//    "Monthly Time Series": {
//        "2023-08-04": {
//            "1. open": "196.2350",
//            "2. high": "196.7300",
//            "3. low": "181.9200",
//            "4. close": "181.9900",
//            "5. volume": "263870876"
//        },
//        "2023-07-31": {
//            "1. open": "193.7800",
//            "2. high": "198.2300",
//            "3. low": "186.6000",
//            "4. close": "196.4500",
//            "5. volume": "996368613"
//        },
//        "2023-06-30": {
//            "1. open": "177.7000",
//            "2. high": "194.4800",
//            "3. low": "176.9306",
//            "4. close": "193.9700",
//            "5. volume": "1297863403"
//        }
//    }
//}
