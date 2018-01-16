//
//  ItunesEntity.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

protocol ItunesEntity: QueryItemProvider {
    var entityName: String { get }
}

extension ItunesEntity {
    var queryItem: URLQueryItem {
        return URLQueryItem(name: "entity", value: entityName)
    }
}

enum MusicEntity: String {
    case musicArist
    case musicTrack
    case album
    case musicVideo
    case mix
    case song
}

extension MusicEntity: ItunesEntity {
    var entityName: String {
        return self.rawValue
    }
}
