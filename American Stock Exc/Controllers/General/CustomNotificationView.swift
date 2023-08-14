//
//  CustomNotificationView.swift
//  College Website
//
//  Created by Atharva Padekar on 01/08/23.
//

import UIKit

class CustomNotificationView: UIView {

    private let messageLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.numberOfLines = 0 // Allow multiple lines for longer messages
            return label
        }()
        
        // Convenience method to show the notification with a given message.
        func show(withMessage message: String) {
            messageLabel.text = message
            
            // Customize the notification appearance and layout here, e.g., background color, corner radius, etc.
            //tintColor = .black
            backgroundColor =  UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
            
            layer.cornerRadius = 10
            // Add the message label as a subview and set up constraints.
            addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: topAnchor),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

}
