//
//  ContentView.swift
//  ACG
//
//  Created by Alyx Ferrari on 10/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CPUPicker()
            ChipsetPicker()
            GPUPicker()
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
