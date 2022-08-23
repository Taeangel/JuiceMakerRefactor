//
//  Color+.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/23.
//

import SwiftUI

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
    static let peach = Color(hex: "#ff8882")
    static let ivory = Color(hex: "f8ede3")
    static let brown = Color(hex: "897853")
}
 
