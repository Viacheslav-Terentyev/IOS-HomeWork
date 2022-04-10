//
//  PostNews.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 18.03.2022.
//

import Foundation

struct News: ViewModelProtocol {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

