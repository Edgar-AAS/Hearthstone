//
//  CardCellsType.swift
//  HearthstoneApp
//
//  Created by Edgar Arlindo on 11/12/23.
//

import Foundation

enum CategoryCellDataSource: Equatable {
    case classes(CategoryCellDTO)
    case races(CategoryCellDTO)
    case factions(CategoryCellDTO)
    case qualities(CategoryCellDTO)
    case types(CategoryCellDTO)
}
