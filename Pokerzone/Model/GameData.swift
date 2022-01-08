//
//  DataModel.swift
//  Pokerzone
//
//  Created by Esraa Gamal on 07/01/2022.
//

import Foundation

struct GameData {
    let tableName, gameName, Stakes : String
    let seats, players, waitlist, hands_Hr : Int
    let buyIn, avg : String
    let floopSeen : Double
    var isFavorite : Bool
}

enum CellIdentifiers : Int, CustomStringConvertible{
   
   case TableName = 0
   case Game
   case Stakes
   case BuyIn
   case Seats
   case Players
   case Waitlist
   case Avg
   case FloopSeen
   case Hands_Hr
   case Favorite
   
   var description: String {
       switch self {
       
       case .TableName:
           return "TableName"
       case .Game:
           return "Game"
       case .Stakes:
           return "Stakes"
       case .BuyIn:
           return "BuyIn"
       case .Seats:
           return "Seats"
       case .Players:
           return "Players"
       case .Waitlist:
           return "Waitlist"
       case .Avg:
           return "Avg"
       case .FloopSeen:
           return "FloopSeen"
       case .Hands_Hr:
           return "Hands-Hr"
       case .Favorite:
           return "Favorite"

       }
   }
}
