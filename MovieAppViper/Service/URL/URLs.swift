//
//  URLs.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation

struct URLBase{
    let baseURL = "https://api.themoviedb.org/3/"
    let APIKey = "?api_key=71b071ea5d1e233188a3f15f06566fed&language=en-US"
}

struct URLEndPoint{
    let moviePopularUrl = URL(string: URLBase().baseURL + "movie/popular" + URLBase().APIKey)!
    let movieTopRatedUrl = URL(string: URLBase().baseURL + "movie/top_rated" + URLBase().APIKey)!
    let movieUpcomingdUrl = URL(string: URLBase().baseURL + "movie/upcoming" + URLBase().APIKey)!
    let seriesPopularUrl = URL(string: URLBase().baseURL + "tv/popular" + URLBase().APIKey)!
    let seriesTopRatedUrl = URL(string: URLBase().baseURL + "tv/top_rated" + URLBase().APIKey)!
    let seriesTAUrl = URL(string: URLBase().baseURL + "tv/airing_today" + URLBase().APIKey)!
    
}
