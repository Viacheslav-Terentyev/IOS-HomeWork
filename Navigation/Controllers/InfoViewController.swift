//
//  InfoViewController.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 02.03.2022.
//
import UIKit

class InfoViewController: UIViewController {
    
    // Создаем кнопку
    private var button: UIButton = {
        let button = UIButton()
        
        // Текст кнопки
        button.setTitle("Показать алерт", for: .normal)
        
        // Цвет текста
        button.setTitleColor(.black, for: .normal)
        
        // Action
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        // Цвет кнопки
        button.backgroundColor = .systemYellow
        
        // Скругляем кнопку
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        // Отключаем Autoresizingmask
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Возвращаем кнопку
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.button)
        view.backgroundColor = .systemGreen
        
        // Констеинты
        setConstraints()
        
    }
    
    // Метод с добавлением констреинтов
    func setConstraints() {
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Внимание, что то важное", message: "Какое то соббщение всплывающего окна", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            print("Нажата кнопка ОК")
        }
        let chancel = UIAlertAction(title: "Отмена", style: .cancel) { UIAlertAction in
            print("Нажата кнопка Отмена")
        }
        
        alert.addAction(action)
        alert.addAction(chancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
