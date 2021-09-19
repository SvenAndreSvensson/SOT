//
//  LinearGradient+predefined.swift
//  SOT
//
//  Created by Sven Svensson on 19/09/2021.
//

import Foundation
import SwiftUI

extension LinearGradient{
    
    static var editItemColors: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.3), Color.clear.opacity(0)]), startPoint: .top, endPoint: .bottom)
    }
 
    static var newItemColors: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.3), Color.clear.opacity(0)]), startPoint: .top, endPoint: .bottom)
    }
}
