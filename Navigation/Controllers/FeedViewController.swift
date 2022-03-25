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
        
        // Метод с заданными констрейтами кнопки
        setConstraints()
    }
    
    // Делаем переход на экран с постом
    @objc private func didTapButton() {
        let postViewController = PostViewController()
        // Передаем объект post в PostViewController
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    // Метод добавления констрейтов
    private func setConstraints() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
