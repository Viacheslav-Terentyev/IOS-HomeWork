//
//  LoginViewController.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 18.03.2022.
//
import UIKit

// Для входа логин: netology@mail.ru пароль: 1234567

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Логотип
    private lazy var logoView: UIImageView = {
        let logoView = UIImageView(image: UIImage(named: "Image"))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        return logoView
    }()
    
    // Логин
    private lazy var loginTextField: UITextField = {
         let textField = UITextField()
         textField.translatesAutoresizingMaskIntoConstraints = false
         textField.autocapitalizationType = .none
         textField.backgroundColor = .systemGray6
         textField.textColor = .black
         textField.font = UIFont.systemFont(ofSize: 16.0)
         textField.layer.borderWidth = 0.5
         textField.layer.borderColor = UIColor.lightGray.cgColor
         let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
         textField.leftView = leftView
         textField.leftViewMode = .always
         textField.clipsToBounds = true
         textField.placeholder = "E-mail ..."
         return textField
     }()
    
    // Пароль
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.placeholder = "Password ..."
        return textField
    }()
    
    // Кнопка
    private lazy var initButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Log in", for: .normal)
        let image = UIImage(named: "logo")
        button.setBackgroundImage(image, for: .normal)
        if button.isSelected {
            button.alpha = 0.8
        } else if button.isHighlighted {
            button.alpha = 0.8
        } else {
            button.alpha = 1.0
        }
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
    }()
    
    // Лэйбл с предупреждением
    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите 6 или более символов"
        label.textColor = .black
        label.isHidden = true
        label.font = UIFont(name: "Helvetica-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.setUpView()
        self.tapGesture()
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func kbWillShow(notification: NSNotification) {
        if let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height * 0.25)
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
        }
    }
    
    @objc func kbWillHide(notification: NSNotification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
    private var topButtonConstraint: NSLayoutConstraint?
    
    private func setUpView() {
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(textFieldStackView)
        self.scrollView.addSubview(logoView)
        self.scrollView.addSubview(initButton)
        self.textFieldStackView.addArrangedSubview(loginTextField)
        self.textFieldStackView.addArrangedSubview(passwordTextField)
        
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        
        let bottomLogoConstraint = self.logoView.bottomAnchor.constraint(equalTo: self.textFieldStackView.topAnchor, constant: -70)
        let heightLogoConstraint = self.logoView.heightAnchor.constraint(equalToConstant: 100)
        let widthLogoConstraint = self.logoView.widthAnchor.constraint(equalToConstant: 100)
        let centerXLogoConstraint = self.logoView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        
        let stackViewCenterXConstraint = self.textFieldStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let stackViewCenterYConstraint = self.textFieldStackView.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor)
        let stackViewLeadingConstraint = self.textFieldStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.textFieldStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)
        
        let infoTextFieldHeightAnchor = self.loginTextField.heightAnchor.constraint(equalToConstant: 50)
        let passwordTextFieldHeightAnchor = self.passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        
        self.topButtonConstraint = self.initButton.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: 16)
        self.topButtonConstraint?.priority = UILayoutPriority(rawValue: 999)
        let buttonLeadingConstraint = self.initButton.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.initButton.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)
        let heightButtonConstraint = self.initButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        NSLayoutConstraint.activate([ scrollViewTopConstraint, scrollViewRightConstraint, scrollViewBottomConstraint, scrollViewLeftConstraint, heightLogoConstraint, widthLogoConstraint,  centerXLogoConstraint, bottomLogoConstraint, stackViewCenterXConstraint, stackViewCenterYConstraint, stackViewLeadingConstraint, stackViewTrailingConstraint, infoTextFieldHeightAnchor, passwordTextFieldHeightAnchor, heightButtonConstraint, self.topButtonConstraint, buttonLeadingConstraint,  buttonTrailingConstraint].compactMap( {$0} ))
    }
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func validPassword(userPassword : String) -> Bool
    {
        
        let passwordReg =  (".{6,}")
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)
        return passwordTesting.evaluate(with: userPassword)
    }
    
    func isValidEmail(userEmail: String) -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: userEmail)
    }
    
    
    @objc private func didTapButton() {
        if initButton.isSelected {
            initButton.alpha = 0.8
        } else if initButton.isHighlighted {
            initButton.alpha = 0.8
        } else if !initButton.isEnabled {
            initButton.alpha = 0.8
        } else {
            initButton.alpha = 1
        }
        
        
        let topLabelConstraint = self.warningLabel.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: -10)
        let leadingLabelConstraint = self.warningLabel.leadingAnchor.constraint(equalTo: self.textFieldStackView.leadingAnchor)
        let heightLabelConstraint = self.warningLabel.heightAnchor.constraint(equalToConstant: 40)
        let trailingLabelConstraint = self.warningLabel.trailingAnchor.constraint(equalTo: self.textFieldStackView.trailingAnchor)
        
        self.topButtonConstraint = self.initButton.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: 16)
        
        let email = isValidEmail(userEmail: loginTextField.text!)
        
        if(email == false)
        {
            let alert = UIAlertController(title: "Внимание!", message: "Некорректный email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let password = validPassword(userPassword: passwordTextField.text!)
        
        if(password == false)
        {
            self.warningLabel.isHidden = false
            self.scrollView.addSubview(self.warningLabel)
            self.topButtonConstraint?.isActive = false
            NSLayoutConstraint.activate([topLabelConstraint, leadingLabelConstraint, trailingLabelConstraint, heightLabelConstraint, topButtonConstraint].compactMap( {$0} ))
        } else {
            self.warningLabel.removeFromSuperview()
            NSLayoutConstraint.deactivate([ topLabelConstraint, leadingLabelConstraint, trailingLabelConstraint, heightLabelConstraint
                                          ].compactMap( {$0} ))
            self.warningLabel.isHidden = true
        }
        
        if self.loginTextField.text == "" {
            loginTextField.shake()
        } else if passwordTextField.text == "" {
            loginTextField.shake()
        } else if self.loginTextField.text == "netology@mail.ru" && passwordTextField.text == "1234567" {
            
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Внимание!", message: "Данные введены неверно", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

