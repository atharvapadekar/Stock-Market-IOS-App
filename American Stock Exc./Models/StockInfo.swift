//
//  stockInfoSingle.swift
//  College Website
//
//  Created by Atharva Padekar on 02/08/23.
//

import Foundation

//{
//    "Meta Data": {
//        "1. Information": "Monthly Prices (open, high, low, close) and Volumes",
//        "2. Symbol": "TSCO.LON",
//        "3. Last Refreshed": "2023-08-01",
//        "4. Time Zone": "US/Eastern"
//    },
//    "Monthly Time Series": {
//        "2023-08-01": {
//            "1. open": "257.9000",
//            "2. high": "260.1510",
//            "3. low": "257.7000",
//            "4. close": "258.8000",
//            "5. volume": "6568009"
//        },
//        "2023-07-31": {
//            "1. open": "250.9000",
//            "2. high": "264.8000",
//            "3. low": "244.2000",
//            "4. close": "258.0000",
//            "5. volume": "432634258"
//        }
//    }
//}

struct StockInfo: Codable {
    let metaData: MetaData
    let monthlyTimeSeries: [String: Details]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case monthlyTimeSeries = "Monthly Time Series"
    }
}



struct MetaData: Codable {
    let information: String
    let symbol: String
    let lastRefreshed: String
    let timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case timeZone = "4. Time Zone"
    }
}

struct Details: Codable {
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}

//StockInfo(metaData: College_Website.MetaData(information: "Monthly Prices (open, high, low, close) and Volumes", symbol: "IBM", lastRefreshed: "2023-08-01", timeZone: "US/Eastern"), monthlyTimeSeries: ["2007-01-31": College_Website.Details(open: "97.1700", high: "100.9000", low: "94.5500", close: "99.1500", volume: "192702000"), "2021-04-30": College_Website.Details(open: "133.7600", high: "148.7400", low: "130.3800", close: "141.8800", volume: "122920494"), "2017-04-28": College_Website.Details(open: "173.8200", high: "176.3300", low: "159.6000", close: "160.2900", volume: "80758989"),



