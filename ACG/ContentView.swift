//
//  ContentView.swift
//  ACG
//
//  Created by Alyx Ferrari on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            CPUPicker()
            ChipsetPicker()
            GPUPicker()
            WirelessPicker()
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
