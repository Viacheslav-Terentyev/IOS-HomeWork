//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 02.03.2022.
//
import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Профиль"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}
