//
//  CardModel.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 06/12/23.
//
import Foundation

struct CardModel: Model {
    let cardId: String
    let name: String?
    let rarity: String?
    let cardSet: String?
    let type: String?
    let img: String?
    let imgGold: String?
    let cost: Int?
    let attack: Int?
    let health: Int?
}

