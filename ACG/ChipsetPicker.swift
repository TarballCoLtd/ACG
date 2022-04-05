//
//  ChipsetPicker.swift
//  ACG
//
//  Created by Alyx Ferrari on 11/6/21.
//

import SwiftUI

struct ChipsetPicker: View {
    // support constants
    private static let supported = "Support status: Supported ✅"
    private static let conditionallySupported = "Support status: Conditionally supported ⚠️"
    // amd chipsets
    private static let amdAM4Chipsets: [String] = ["A320", "B350", "X370", "B450", "X470", "A520", "B550", "X570"]
    // vendor
    @State private var vendor: String = "Vendor"
    // socket
    @State private var socket: String = "Socket"
    @State private var socketDisabled: Bool = true
    @State private var socketArray: [String] = []
    // chipset
    @State private var chipset: String = "Chipset"
    @State private var chipsetDisabled: Bool = true
    @State private var chipsetArray: [String] = []
    // indices
    @State private var vendorIndex: Int = -1
    @State private var socketIndex: Int = -1
    @State private var chipsetIndex: Int = -1
    // states
    @State private var status: String = "Support status: Unknown ❓"
    @State private var infoText: String = ""
    var body: some View {
        VStack {
            Text("Chipset")
            HStack {
                Menu(vendor) {
                    Button("AMD") {
                        vendorIndex = 0
                        socketIndex = -1
                        chipsetIndex = -1
                        vendor = "AMD"
                        socket = "Socket"
                        chipset = "Chipset"
                        socketDisabled = false
                        chipsetDisabled = true
                        genStatus()
                    }
                    Text("Intel")
                }
                Menu(socket) {
                    Text("AM3+")
                    Button("AM4") {
                        chipsetDisabled = false
                        chipsetIndex = -1
                        chipset = "Chipset"
                        socket = "AM4"
                        socketIndex = 1
                        chipsetArray = ChipsetPicker.amdAM4Chipsets
                    }
                }.disabled(socketDisabled)
                Menu(chipset) {
                    ForEach(Array(chipsetArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            chipset = element
                            chipsetIndex = index
                            genStatus()
                        }
                    }
                }.disabled(chipsetDisabled)
            }
            HStack {
                Text(infoText == "" ? status : "\(status)\n\n\(infoText)")
                #if os(macOS)
                Spacer()
                #endif
            }
        }
    }
    private func genStatus() {
        status = "Support status: Unknown ❓"
        infoText = ""
        if vendorIndex == 0 && socketIndex == 1 {
            if chipsetIndex == -1 {
                return
            } else if chipsetIndex == 5 || chipsetIndex == 6 {
                status = ChipsetPicker.conditionallySupported
                infoText = "This chipset is supported, but requires SSDT-CPUR."
            } else {
                status = ChipsetPicker.supported
                infoText = "This chipset is supported and will work without any special configuration."
            }
        }
    }
}

struct ChipsetPicker_Previews: PreviewProvider {
    static var previews: some View {
        ChipsetPicker()
    }
}
