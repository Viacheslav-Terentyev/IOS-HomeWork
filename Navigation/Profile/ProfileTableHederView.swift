//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 25.03.2022.
//

import UIKit

class ProfileTableHederView: UITableViewHeaderFooterView, UITextFieldDelegate, UIGestureRecognizerDelegate {
    

    var statusText: String? // переменная для хранения текста статуса
    
    // Создаем аватар
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ДартВейдер"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // Создаем лэйбл с именем
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text  = "Darth Vader"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return nameLabel
    }()
    
    // Создаем лэйбл со статусом
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = .gray
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        return statusLabel
    }()
    
    // Создаем кнопку Show status
    private lazy var statusButton: UIButton = {
        let statusButton = UIButton()
        statusButton.setTitle("Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        statusButton.backgroundColor = .blue
        statusButton.layer.cornerRadius = 4
        statusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shouldRasterize = true
        return statusButton
    }()
    
    private lazy var labelStackView: UIStackView = { 
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var avatarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal 
        stackView.spacing = 16
        return stackView
    }()
    
    // Текстовое поле
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 2))
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.placeholder = "Введите статус"
        return textField
    }()
    
    
    private var buttonTopConstrain: NSLayoutConstraint?
    
    weak var delegate: ProfileHeaderViewProtocol? 
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createSubviews() {
        self.addSubview(avatarStackView)
        self.addSubview(textField)
        self.addSubview(statusButton)
        self.avatarStackView.addArrangedSubview(avatar)
        self.avatarStackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(nameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)
        self.textField.delegate = self
        setupConstraints()
    }
    
    func setupConstraints() {
        let avatarStackViewTopConstraint = self.avatarStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let avatarStackViewLeadingConstraint = self.avatarStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let avatarStackViewTrailingConstraint = self.avatarStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let avatarImageViewRatioConstraint = self.avatar.heightAnchor.constraint(equalTo: self.avatar.widthAnchor, multiplier: 1.0)
        self.buttonTopConstrain = self.statusButton.topAnchor.constraint(equalTo: self.avatarStackView.bottomAnchor, constant: 16)
        self.buttonTopConstrain?.priority = UILayoutPriority(rawValue: 999)
        let buttonLeadingConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let buttonTrailingConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let buttonHeightConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        let buttonBottomConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            avatarStackViewTopConstraint, avatarStackViewLeadingConstraint,
            avatarStackViewTrailingConstraint, avatarImageViewRatioConstraint,
            self.buttonTopConstrain, buttonLeadingConstraint, buttonTrailingConstraint,
            buttonHeightConstraint, buttonBottomConstraint
        ].compactMap( {$0} ))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    @objc func buttonAction() {
        let topConstrain = self.textField.topAnchor.constraint(equalTo: self.avatarStackView.bottomAnchor, constant: -10)
        let leadingConstrain = self.textField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor)
        let trailingConstrain = self.textField.trailingAnchor.constraint(equalTo: self.avatarStackView.trailingAnchor)
        let textHeight = self.textField.heightAnchor.constraint(equalToConstant: 40)
        self.buttonTopConstrain = self.statusButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16)
        
        if self.textField.isHidden {
            self.addSubview(self.textField)
            textField.text = nil
            statusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstrain?.isActive = false
            NSLayoutConstraint.activate([topConstrain, leadingConstrain, trailingConstrain, textHeight, buttonTopConstrain].compactMap( {$0} ))
            textField.becomeFirstResponder()
        } else {
            statusText = textField.text! // Меняем текст
            statusLabel.text = "\(statusText ?? "")"
            statusButton.setTitle("Show status", for: .normal)
            self.textField.removeFromSuperview()
            NSLayoutConstraint.deactivate([
                topConstrain, leadingConstrain, trailingConstrain, textHeight
            ].compactMap( {$0} ))
        }
        self.delegate?.buttonAction(inputTextIsVisible: self.textField.isHidden) { [weak self] in
            self?.textField.isHidden.toggle()
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        let status: String = textField.text ?? ""
        print("Новый статус = \(status)")
    }
}
