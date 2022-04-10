//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 25.03.2022.
//

import UIKit

protocol ProfileTableHeaderViewProtocol: AnyObject {
    func buttonAction()
    func delegateActionAnimatedAvatar(cell: ProfileTableHeaderView)
}

class ProfileTableHeaderView: UITableViewHeaderFooterView {

    private var statusText: String?
    
    // Создаем аватар
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Avatar"))
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
        nameLabel.text  = "Вячеслав Терентьев"
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return nameLabel
    }()
    
    // Создаем лэйбл со статусом
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // Создаем кнопку Show status
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shouldRasterize = true
        button.layer.shadowPath =  UIBezierPath(rect: button.bounds).cgPath
        return button
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
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.placeholder = "Введите статус"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 2))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.delegate = self
        return textField
    }()
    
    weak var delegate: ProfileTableHeaderViewProtocol?
    
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        self.addSubview(avatarStackView)
        self.avatarStackView.addArrangedSubview(avatar)
        self.avatarStackView.addArrangedSubview(labelStackView)
        self.labelStackView.addArrangedSubview(nameLabel)
        self.labelStackView.addArrangedSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(statusButton)
        self.setupConstraints()
        self.setupTapGesture()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarStackView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            avatar.widthAnchor.constraint(equalToConstant: 138),
            avatar.heightAnchor.constraint(equalToConstant: 138),
            
            statusTextField.topAnchor.constraint(equalTo: self.avatarStackView.bottomAnchor, constant: -10),
            statusTextField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: self.labelStackView.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            statusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func buttonAction() {
        guard statusTextField.text != "" else {
            statusTextField.shake()
            return
        }
        statusText = self.statusTextField.text!
        statusLabel.text = "\(statusText ?? "")"
        self.statusTextField.text = nil
        self.endEditing(true)
    }
}

extension ProfileTableHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}

extension ProfileTableHeaderView: UIGestureRecognizerDelegate {
    
    private func setupTapGesture() {
        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
        self.avatar.addGestureRecognizer(self.tapGestureRecognizer)
        self.avatar.isUserInteractionEnabled = true
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard self.tapGestureRecognizer === gestureRecognizer else { return }
        delegate?.delegateActionAnimatedAvatar(cell: self)
    }
}
