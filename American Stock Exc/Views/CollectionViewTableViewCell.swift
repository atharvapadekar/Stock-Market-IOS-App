//
//  CollectionViewTableViewCell.swift
//  College Website
//
//  Created by Atharva Padekar on 03/08/23.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    let titleLabel: UILabel
    let symbolLabel: UILabel
    let openLabel: UILabel
    let highLabel: UILabel
    let lowLabel: UILabel
    let closeLabel: UILabel
    let volumeLabel: UILabel
    let sceneLabel: UILabel
    let statusLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        titleLabel = UILabel()
        symbolLabel = UILabel()
        openLabel = UILabel()
        highLabel = UILabel()
        lowLabel = UILabel()
        closeLabel = UILabel()
        volumeLabel = UILabel()
        sceneLabel = UILabel()
        statusLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        //backgroundColor = .clear
            //UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 0.1)
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true
        //contentView.layer.masksToBounds = true
        setupViews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
           // Other cell setup...
           
           // Add the titleLabel as a subview
        contentView.addSubview(titleLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(openLabel)
        contentView.addSubview(highLabel)
        contentView.addSubview(lowLabel)
        contentView.addSubview(closeLabel)
        contentView.addSubview(volumeLabel)
        contentView.addSubview(sceneLabel)
        contentView.addSubview(statusLabel)
           
           // Set constraints for the titleLabel if necessary
           // For example, to center the label vertically and horizontally:
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16).isActive = true
        
        symbolLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        symbolLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 16).isActive = true
        
        openLabel.font = UIFont.systemFont(ofSize: 13)
        openLabel.translatesAutoresizingMaskIntoConstraints = false
        openLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10).isActive = true
        openLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        highLabel.font = UIFont.systemFont(ofSize: 13)
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 10).isActive = true
        highLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        lowLabel.font = UIFont.systemFont(ofSize: 13)
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10).isActive = true
        lowLabel.leadingAnchor.constraint(equalTo: openLabel.trailingAnchor, constant: 15).isActive = true
        
        closeLabel.font = UIFont.systemFont(ofSize: 13)
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        closeLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 10).isActive = true
        closeLabel.leadingAnchor.constraint(equalTo: highLabel.trailingAnchor, constant: 16).isActive = true
        
        volumeLabel.font = UIFont.systemFont(ofSize: 13)
        volumeLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 10).isActive = true
        volumeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        sceneLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        sceneLabel.translatesAutoresizingMaskIntoConstraints = false
        sceneLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 10).isActive = true
        sceneLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        statusLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
       }
    
}
