//
//  LoginVC.swift
//  College Website
//
//  Created by Atharva Padekar on 19/07/23.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
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
                notificationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                //notificationView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400)
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
            label.text = "American Stock Exhange"
        label.font = UIFont.systemFont(ofSize: 24, weight: .thin)
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()

    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(titleLabel)
        view.addSubview(logoImageView)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            usernameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: -100),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -50),
            
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 120),
            signUpButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    
    @objc func loginButtonTapped() {
        
        let em = usernameTextField.text ?? ""
        let pw = passwordTextField.text ?? ""
        
        func loginUser(email: String, password: String) {
                Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                    if let error = error {
                        print("Error during user login: \(error.localizedDescription)")
                        self.showNotification(withMessage: error.localizedDescription)
                    } else {
                        print("User login successful!")
                        self.showNotification(withMessage: "Login Successful!")
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+4){
                            self.switchToHomeViewController()
                        }
                        
                        // You can handle the successful login here.
                    }
                }
            }
        
        loginUser(email: em, password: pw)
    }
    
    @objc func signUpButtonTapped() {
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func switchToHomeViewController() {
            let homeViewController = MainTabBarVC() // Replace HomeViewController with the actual class name of your home view controller
            let navigationController = UINavigationController(rootViewController: homeViewController)
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = navigationController
                }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }

}


// FGX1Q50YKM68392K


