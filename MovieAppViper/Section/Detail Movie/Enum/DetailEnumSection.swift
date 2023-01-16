//
//  DetailEnumSection.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 16/01/23.
//

import Foundation

enum DetailEnumSection {
    case cast, similarMovies
    
    var title : String {
        switch self {
        case .cast:
            return "Cast"
        case .similarMovies:
            return "Similar Movies"
        }
    }
}
