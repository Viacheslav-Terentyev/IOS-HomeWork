//
//  PostViewController.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 02.03.2022.
//
import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(actionButton))
        
    }
    
    // Кнопка action
    @objc private func actionButton() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        self.navigationController?.present(infoViewController, animated: true, completion: nil)
    }
}
