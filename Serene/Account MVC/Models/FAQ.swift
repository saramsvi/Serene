//
//  FAQ.swift
//  Serene
//
//  Created by MSVI on 16.01.22.
//decoding  from json  file

import Foundation

struct FAQ : Decodable, Identifiable  {
    var id: Int
    var question : String
    var answer: String
}
