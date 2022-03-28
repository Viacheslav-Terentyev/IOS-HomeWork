//
//  PostNews.swift
//  Navigation
//
//  Created by Вячеслав Терентьев on 18.03.2022.
//
import Foundation

struct News: Decodable {

    struct Article: Decodable  {
        var author: String
        var description: String
        var image: String
        var likes: Int
        var views: Int
 
        enum CodingKeys: String, CodingKey {
            case author, description, image, likes, views
        }
    }
    
    // Массив статей
    let articles: [Article]
}
