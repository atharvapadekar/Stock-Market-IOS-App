//
//  SignUpVC.swift
//  College Website
//
//  Created by Atharva Padekar on 01/08/23.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    private let notificationView = CustomNotificationView()
    
    func showNotification(withMessage message: String) {
            // Add the notification view as a subview to your main view.
            view.addSubview(notificationView)
            
            // Set up constraints for the notification view to fill the main view.
            notificationView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                notificationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                notificationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                notificationView.heightAnchor.constraint(equalToConstant: 200),
                notificationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
                
            ])
        
            notificationView.backgroundColor = .gray
            notificationView.layer.cornerRadius = 10
        
            notificationView.show(withMessage: message)
                
                // Schedule a timer to hide the notification after a few seconds (optional).
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hideNotification()
            }
    }
    
    func hideNotification() {
            notificationView.removeFromSuperview()
        }
    
    private let logoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "collegeLogo")
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Register"
            label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()
        

    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(notificationView)
        
        NSLayoutConstraint.activate([
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: 120),
            
            
            
        ])
        
    }
    
    @objc func registerButtonTapped() {
        
        let em = usernameTextField.text ?? ""
        let pw = passwordTextField.text ?? ""
        
        func registerUser(email: String, password: String) {
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    if let error = error {
                        print("Error during user registration: \(error.localizedDescription)")
                        self.showNotification(withMessage: error.localizedDescription)
                    } else {
                        print("User registration successful!")
                        self.showNotification(withMessage: "Registration Successful!")
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
                            
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        // You can handle the successful registration here.
                    }
                }
            }
        
        registerUser(email: em, password: pw)
                
    }
    
    
}

