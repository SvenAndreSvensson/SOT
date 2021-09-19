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
    
    init(){
        // so it's possible to have a color on views with a List
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            SOTView()
                .environmentObject(manager)
        }
    }
}
