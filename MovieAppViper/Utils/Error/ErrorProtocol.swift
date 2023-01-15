//
//  ErrorProtocol.swift
//  MovieAppViper
//
//  Created by Abdiel CT MNC on 13/01/23.
//

import Foundation

protocol ErrorProtocol{
    func getErrCode() -> String
    func getTitle() -> String
    func getDesc() -> String
}
