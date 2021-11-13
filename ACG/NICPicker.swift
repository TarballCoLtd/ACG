//
//  NICPicker.swift
//  ACG
//
//  Created by Alyx Ferrari on 11/10/21.
//

import SwiftUI

struct NICPicker: View {
    // support constants
    private static let supported = "Support status: Natively supported ✅"
    private static let partialSupported = "Support status: Partially supported ⚠️"
    private static let conditionalSupported = "Support status: Conditionally supported ⚠️"
    private static let unsupported = "Support status: Unsupported ❌"
    // card arrays
    private static let intelCards: [String] = ["I210", "I211", "I225LM", "I225-V", "80003ES2LAN", "82545EM", "82566DC", "82571EB"]
    private static let realtekCards: [String] = ["RTL8111", "RTL8112", "RTL8118", "RTL8125", "RTL8168"]
    private static let aquantiaCards: [String] = []
    private static let atherosCards: [String] = []
    private static let broadcomCards: [String] = []
    // vendor
    @State private var vendor: String = "Vendor"
    private static let vendorArray: [String] = ["Intel", "Realtek", "Aquantia", "Atheros", "Broadcom"]
    // card
    @State private var card: String = "Card"
    @State private var cardArray: [String] = []
    @State private var cardDisabled: Bool = true
    // indices
    @State private var vendorIndex: Int = -1
    @State private var cardIndex: Int = -1
    // states
    @State private var status: String = "Support status: Unknown ❓"
    @State private var infoText: String = ""
    var body: some View {
        VStack {
            Text("Ethernet")
            HStack {
                Menu(vendor) {
                    ForEach(Array(NICPicker.vendorArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            vendor = element
                            cardDisabled = false
                            vendorIndex = index
                            cardIndex = -1
                            card = "Card"
                            if index == 0 {
                                cardArray = NICPicker.intelCards
                            } else if index == 1 {
                                cardArray = NICPicker.realtekCards
                            }
                            genStatus()
                        }
                    }
                }
                Menu(card) {
                    ForEach(Array(cardArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            card = element
                            cardIndex = index
                            genStatus()
                        }
                    }
                }.disabled(cardDisabled)
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
        
    }
}

struct NICPicker_Previews: PreviewProvider {
    static var previews: some View {
        NICPicker()
    }
}
