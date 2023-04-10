//
//  NotePadApp.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import SwiftUI
import SwiftUINavigator

@main
struct NotePadApp: App {
    var body: some Scene {
        WindowGroup {
            NavView(showDefaultNavBar: false) {
                NotesListScreen()
            }
        }
    }
}
