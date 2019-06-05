//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Dustin Koch on 6/5/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}

