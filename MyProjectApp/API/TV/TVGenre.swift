//
//  TVGenre.swift
//  MyProjectApp
//
//  Created by admin on 09/04/2024.
//

import Foundation


        
enum TVGenre: Int, CaseIterable, Codable {
    case actionAdventure = 10759
    case animation = 16
    case komödie = 35
    case krimi = 80
    case dokumentarfilm = 99
    case drama = 18
    case familie = 10751
    case kids = 10762
    case news = 10763
    case reality = 10764
    case sciFiFantasy = 10765
    case mystery = 9648
    case soap = 10766
    case talk = 10767
    case warPolitics = 10768
    case western = 37
    
    static let allGenres: [TVGenre] = allCases
    
    var title: String {
        switch self {
        case .actionAdventure:
            return "Action & Adventure"
        case .animation:
            return "Animation"
        case .komödie:
            return "Komödie"
        case .krimi:
            return "Krimi"
        case .dokumentarfilm:
            return "Dokumentarfilm"
        case .drama:
            return "Drama"
        case .familie:
            return "Familie"
        case .kids:
            return "Kids"
        case .news:
            return "News"
        case .reality:
            return "Reality"
        case .mystery:
            return "Mystery"
        case .sciFiFantasy:
            return "Sci-Fi & Fantasy"
        case .soap:
            return "Soap"
        case .talk:
            return "Talk"
        case .warPolitics:
            return "War & Politics"
        case .western:
            return "Western"
        }
    }
    
    var footerTitle: String {
        return "Explore \(title) Movies"
    }
}
