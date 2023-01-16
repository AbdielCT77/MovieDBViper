//
//  HomeEnumSection.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 14/01/23.
//

import Foundation

enum HomeEnumSection {
    case upComingMovie, nowPlaying, popularMovie
    
    var title : String {
        switch self {
        case .upComingMovie:
            return "Upcoming Movies"
        case .nowPlaying:
            return "Now Playing"
        case .popularMovie:
            return "Popular Movies"
        }
    }
}
