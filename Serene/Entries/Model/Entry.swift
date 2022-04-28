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
        date: "DD.MM.YYYY",
        CardColorTop: "Yellow",
        CardColorDown: "LightBlue",
        image: "Illustration 1",
        show: false,
        index: -1
    ),
    Entry(
        mood: "SAD",
        date: "DD.MM.YYYY",
        CardColorTop: "Green",
        CardColorDown: "Purple",
        image: "Illustration 2",
        show: false,
        index: -1
    ),
    Entry(
        mood: "Mixed Feelings",
        date: "DD.MM.YYYY",
        CardColorTop: "Grey",
        CardColorDown: "Purple",

        image: "Illustration 3",
        show: false,
        index: -1
    ),
    Entry(
        mood: "ANGRY",
        date: "DD.MM.YYYY",
        CardColorTop: "Red",
        CardColorDown: "LightBlue",
        image: "Illustration 4",
        show: false,
        index: -1
    ),
    Entry(
        mood: "RELAXED",
        date: "DD.MM.YYYY",
        CardColorTop: "LightBlue",
        CardColorDown: "Purple",
        image: "Illustration 5",
        show: false,
        index: -1
    ),
    Entry(
        mood: "CONFUSED",
        date: "DD.MM.YYYY",
        CardColorTop: "DarkPurple",
        CardColorDown: "LightBlue",
        image: "Illustration 6",
        show: false,
        index: -1
    ),
    Entry(
        mood: "STRESSED",
        date: "DD.MM.YYYY",
        CardColorTop: "Orange",
        CardColorDown: "Purple",
        image: "Illustration 7",
        show: false,
        index: -1
    ),
]
