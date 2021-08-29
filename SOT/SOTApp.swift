//
//  SOTApp.swift
//  SOT
//
//  Created by Sven Svensson on 27/08/2021.
//

import SwiftUI

@main
struct SOTApp: App {
    @StateObject var manager = SOTManager()
    
    var body: some Scene {
        WindowGroup {
            SOTView()
                .environmentObject(manager)
        }
    }
}
