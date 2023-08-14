//
//  SearchResponseTableViewCell.swift
//  College Website
//
//  Created by Atharva Padekar on 10/08/23.
//

import UIKit

class SearchResponseTableViewCell: UITableViewCell {
    
    static let identifier = "SearchResponseTableViewCell"
    
    let nameLabel: UILabel
    let symbolLabel: UILabel
    let typeLabel: UILabel
    let regionLabel: UILabel
    let currencyLabel: UILabel
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        symbolLabel = UILabel()
        typeLabel = UILabel()
        regionLabel = UILabel()
        currencyLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        setupViews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20))
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(regionLabel)
        contentView.addSubview(currencyLabel)
        
        nameLabel.font = UIFont.systemFont(ofSize: 15)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16).isActive = true
        
        symbolLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        symbolLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16).isActive = true
        
        currencyLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10).isActive = true
        currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        currencyLabel.textColor = .systemGreen
        
        typeLabel.font = UIFont.systemFont(ofSize: 13)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        regionLabel.font = UIFont.systemFont(ofSize: 13)
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        regionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10).isActive = true
        regionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
    }

}
