//
//  FeedViewController.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 02.03.2022.
//
import UIKit

class FeedViewController: UIViewController {
    
    // Создаем объект Post
    var post = Post(title: "Мой пост")
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    // Создаем кнопку для перехода на на экран поста
    private lazy var button: UIButton = {
        let button = UIButton()
        // Текст кнопки
        button.setTitle("Перейти на пост", for: .normal)
        
        // Цвет текста
        button.setTitleColor(.black, for: .normal)
        
        // Action
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        // Цвет кнопки
        button.backgroundColor = .systemYellow
        
        // Скугляем кнопку
        button.layer.cornerRadius = 12
        
        //
        button.clipsToBounds = true
        
        // Отключаем AutoresizingMask
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Возвращаем кнопку
        return button
    }()
    
    // Создаем кнопку для перехода на на экран поста
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Цвет экрана
        view.backgroundColor = .white
        
        // Название загаловка
        title = "Лента"
        
        // Задаем жирный текст заголовка
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Переименовываем обратный переход
        navigationItem.backButtonTitle = ""
        
        setButtonStack()
    }
    
    
    func setButtonStack() {
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(button)
        buttonStackView.addArrangedSubview(statusButton)
        
        let buttonStackCenter = buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let buttonStackLeading = buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        let buttonStackTrailing = buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        
        let button = button.heightAnchor.constraint(equalToConstant: 50)
        let statusButton = statusButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([buttonStackCenter,
                                    buttonStackLeading,
                                     buttonStackTrailing,
                                     button, statusButton].compactMap({$0}))
        
    }
    
    // Делаем переход на экран с постом
    @objc private func didTapButton() {
        let postViewController = PostViewController()
        // Передаем объект post в PostViewController
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
}
