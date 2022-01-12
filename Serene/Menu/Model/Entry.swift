//
//  Course.swift
//  DesignCodeUniversal
//
//  Created by Meng To on 6/29/20.
//

import SwiftUI

struct Entry: Identifiable, Hashable {
    var id = UUID()
    var mood: String
    var date: String
    var CardColorTop: String
    var CardColorDown: String
    var image: String
    var show: Bool
    var index: Double
}
var entries = [
    Entry(
        mood: "HAPPY",
        date: "10.October.2000",
        CardColorTop: "Yellow",
        CardColorDown: "LightBlue",
        image: "Illustration 1",
        show: false,
        index: -1
    ),
    Entry(
        mood: "SAD",
        date: "20 sections",
        CardColorTop: "Green",
        CardColorDown: "Purple",
        image: "Illustration 2",
        show: false,
        index: -1
    ),
    Entry(
        mood: "Mixed Feelings",
        date: "12 sections",
        CardColorTop: "Grey",
        CardColorDown: "Purple",

        image: "Illustration 3",
        show: false,
        index: -1
    ),
    Entry(
        mood: "ANGRY",
        date: "12 sections",
        CardColorTop: "Red",
        CardColorDown: "LightBlue",
        image: "Illustration 4",
        show: false,
        index: -1
    ),
    Entry(
        mood: "RELAXED",
        date: "60 sections",
        CardColorTop: "LightBlue",
        CardColorDown: "Purple",
        image: "Illustration 5",
        show: false,
        index: -1
    ),
    Entry(
        mood: "CONFUSED",
        date: "12 sections",
        CardColorTop: "DarkPurple",
        CardColorDown: "LightBlue",
        image: "Illustration 6",
        show: false,
        index: -1
    ),
    Entry(
        mood: "STRESSED",
        date: "12 sections",
        CardColorTop: "Orange",
        CardColorDown: "Purple",
        image: "Illustration 7",
        show: false,
        index: -1
    ),
]
