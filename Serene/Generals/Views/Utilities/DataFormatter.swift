//
//  DataFormatter.swift
//  Serene
//
//  Created by MSVI on 28.04.22.
//

import Foundation
import SwiftUI

func  dateFormatter(_ date: Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat  = "MMMM yyyy"
    return formatter.string(from: date)
}
