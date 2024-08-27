//
//  DropDownMenuViewTestApp.swift
//  DropDownMenuViewTest
//
//  Created by Jae hyung Kim on 8/27/24.
//

import SwiftUI

@main
struct DropDownMenuViewTestApp: App {
    
    @State
    var currentSelectedIndex = 0
    
    var body: some Scene {
        WindowGroup {
            DropDownView(options: ["쉴휴","잭과 콩나물", "맨토스"], selectedOptionIndex: $currentSelectedIndex)
        }
    }
}
