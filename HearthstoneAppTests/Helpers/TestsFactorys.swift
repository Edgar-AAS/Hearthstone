//
//  TestsFactorys.swift
//  HearthstoneAppTests
//
//  Created by Edgar Arlindo on 14/12/23.
//

import Foundation
@testable import HearthstoneApp

func makeUrl() -> URL {
    return URL(string: "any_url.com")!
}

func makeValidData() -> Data {
    let classes = ["any_Class"]
    let races = ["any_Race"]
    let factions = ["any_Faction"]
    let types = ["any_Type"]
    let qualities = ["any_Quality"]
    
    let jsonData = try! JSONSerialization.data(withJSONObject: ["classes": classes,
                                                                "races": races,
                                                                "factions": factions,
                                                                "types": types,
                                                                "qualities": qualities])
    return jsonData
}

func makeCardData() -> Data {
    let cardModel: [CardModel] = [
        .init(cardId: "any_id",
              name: "any_cardName",
              rarity: "any_rarity",
              cardSet: "any_cardSet",
              type: "any_type",
              img: "any_img",
              imgGold: "any_imgGold",
              cost: 1,
              attack: 2,
              health: 3)]
    let data = try! JSONEncoder().encode(cardModel)
    return data
}

func makeCarModel() -> CardModel {
    return CardModel(cardId: "any_id",
                     name: "any_cardName",
                     rarity: "any_rarity",
                     cardSet: "any_cardSet",
                     type: "any_type",
                     img: "any_img",
                     imgGold: "any_imgGold",
                     cost: 1,
                     attack: 2,
                     health: 3)
}

func getCellCategory(index: Int) -> CategoryCellDTO {
    let datasource = [
        CategoryCellDTO(subCategories: ["any_Class"], categorie: "classes"),
        CategoryCellDTO(subCategories: ["any_Race"], categorie: "races"),
        CategoryCellDTO(subCategories: ["any_Faction"], categorie: "factions"),
        CategoryCellDTO(subCategories: ["any_Quality"], categorie: "qualities"),
        CategoryCellDTO(subCategories: ["any_Type"], categorie: "types")
    ]
    return datasource[index]
}

func makePath() -> RequestPath {
    return RequestPath(path: "any/path")
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

func makeRegisterUserRequest() -> RegisterUserRequest {
    return RegisterUserRequest(username: "any_name",
                               email: "email@gmail.com",
                               password: "any_passwordConfirmation",
                               passwordConfirmation: "any_passwordConfirmation")
}

func makeLoginModel() -> LoginModel {
    return LoginModel(email: "any_email", password: "abaxaqui123")
}
