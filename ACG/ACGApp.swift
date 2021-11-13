//
//  ACGApp.swift
//  ACG
//
//  Created by Alyx Ferrari on 10/28/21.
//

import SwiftUI

@main
struct ACGApp: App {
    var body: some Scene {
        WindowGroup {
            ScrollView {
                CPUPicker()
                ChipsetPicker()
                GPUPicker()
                WirelessPicker()
                Spacer()
            }.padding()
        }
    }
}
