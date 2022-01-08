//
//  LobbyViewModel.swift
//  Pokerzone
//
//  Created by Esraa Gamal on 07/01/2022.
//

import Foundation
import RxSwift
import RxCocoa

class LobbyViewModel {
    
    let mainData = BehaviorRelay<[GameData]>(value: [])
    let gameData = BehaviorRelay<[GameData]>(value: [])

    func prepareDataSource() {
        let data1 = GameData(tableName: "Millionaires Table", gameName: "Texas Hold’em", Stakes: "$4,000/$10,000", seats: 6, players: 3, waitlist: 0, hands_Hr: 40, buyIn: "$300,000", avg: "$45,519", floopSeen: 0.4, isFavorite: false)
        let data2 = GameData(tableName: "Millionaires Table", gameName: "New York Hold’em", Stakes: "$5,000/$10,000", seats: 5, players: 4, waitlist: 1, hands_Hr: 45, buyIn: "$200,000", avg: "$43,519", floopSeen: 0.57, isFavorite: false)
        let data3 = GameData(tableName: "Millionaires Table", gameName: "Arizona Hold’em", Stakes: "$3,000/$10,000", seats: 4, players: 5, waitlist: 2, hands_Hr: 48, buyIn: "$100,000", avg: "$44,519", floopSeen: 0.6, isFavorite: false)
        
        let array1 = [GameData](repeating: data1, count: 15)
        let array2 = [GameData](repeating: data2, count: 15)
        let array3 = [GameData](repeating: data3, count: 15)

        var array = array1 + array2 + array3
        array.shuffle()
        mainData.accept(array)
        gameData.accept(array)
    }
}
