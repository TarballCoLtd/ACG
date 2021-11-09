//
//  WirelessPicker.swift
//  ACG
//
//  Created by Alyx Ferrari on 11/6/21.
//

import SwiftUI

struct WirelessPicker: View {
    // card arrays
    private static let broadcomCards: [String] = []
    private static let fenviCards: [String] = []
    private static let atherosCards: [String] = []
    // vendor
    @State private var vendor: String = "Vendor"
    private static let vendorArray: [String] = ["Broadcom", "Fenvi", "Atheros", "USB"]
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
            Text("Chipset")
            HStack {
                Menu(vendor) {
                    ForEach(Array(WirelessPicker.vendorArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            vendor = element
                            cardDisabled = false
                            vendorIndex = index
                            cardIndex = -1
                            card = "Card"
                            if index == 0 {
                                cardArray = WirelessPicker.broadcomCards
                            } else if index == 1 {
                                cardArray = WirelessPicker.fenviCards
                            } else if index == 2 {
                                cardArray = WirelessPicker.atherosCards
                            } else if index == 3 {
                                // usb crap
                            }
                            genStatus()
                        }
                    }
                }
                Menu(card) {
                    ForEach(Array(cardArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            cardIndex = index
                            genStatus()
                        }
                    }
                }.disabled(cardDisabled)
            }
            HStack {
                Text(infoText == "" ? status : "\(status)\n\n\(infoText)")
                Spacer()
            }
        }
    }
    private func genStatus() {
        
    }
}

struct WirelessPicker_Previews: PreviewProvider {
    static var previews: some View {
        WirelessPicker()
    }
}
