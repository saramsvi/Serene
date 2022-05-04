//
//  Contacts.swift
//  Serene
//
//  Created by MSVI on 15.01.22.
//

import Foundation
import SwiftUI

struct Contact: Identifiable {
    var id = UUID()
    var title: String
    var link : String
      
}

let ContactData = [
  //  Contact( title: "MAIL", link: "https://www.youtube.com/watch?v=J-pn5V2jcfo"),
    Contact( title: "LINKEDIN", link: "https://www.linkedin.com/in/saramsvi/"),
    Contact( title: "GITHUB", link: "https://github.com/saramsvi")
]



