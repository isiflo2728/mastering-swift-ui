//
//  Color-Theme.swift
//  MoonShot
//
//  Created by Isidoro Flores on 4/29/26.
//

import SwiftUI

//Whats hapennning here is we are saying extend this protocolo when color is being used

extension ShapeStyle where Self == Color{
    static var darkBackground: Color {
        Color(red : 0.1, green: 0.1, blue: 0.2)
    }
    static var lightBackground: Color {
        Color(red : 0.2, green: 0.2, blue: 0.3)
    }
}
