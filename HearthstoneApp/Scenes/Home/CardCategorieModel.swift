//
//  CategoriesModel.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 10/12/23.
//

import Foundation


protocol Model: Codable, Equatable {}

extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

struct CardCategorieModel: Model {
    let classes: [String]?
    let races: [String]?
    let qualities: [String]?
    let types: [String]?
    let factions: [String]?
}
