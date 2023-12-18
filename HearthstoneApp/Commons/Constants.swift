//
//  Constants.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 05/12/23.
//

import Foundation

struct NetworkConstants {
    struct Auth {
        static let headers = ["X-RapidAPI-Key": "f6abf09f15msh68fb70245742653p1b2df6jsnc4c5125bba07",
                              "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"]
    }
    
    struct Urls {
        static let baseUrl = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards"
        static let races = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/races/"
        static let cardInfos = "https://omgvamp-hearthstone-v1.p.rapidapi.com/info"
    }
    
    struct Locales {
        static let ptBR = "?locale=ptBR"
    }
}

struct AppNameConstants {
    static let appName = "Hearthstone"
    static let categories = "Categories"
    static let cards = "Cards"
}
