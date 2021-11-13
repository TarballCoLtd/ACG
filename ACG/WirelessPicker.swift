//
//  WirelessPicker.swift
//  ACG
//
//  Created by Alyx Ferrari on 11/6/21.
//

import SwiftUI

struct WirelessPicker: View {
    // support constants
    private static let supported = "Support status: Natively supported ✅"
    private static let possibleSupported = "Support status: May be supported ⚠️"
    private static let partialSupported = "Support status: Partially supported ⚠️"
    private static let possibleSupportedIntel = "Support status: May be conditionally supported ⚠️"
    private static let conditionalSupported = "Support status: Conditionally supported ⚠️"
    private static let possiblePartialSupported = "Support status: May be partially supported ⚠️"
    private static let unsupported = "Support status: Unsupported ❌"
    // card arrays
    private static let broadcomCards: [String] = ["BCM94331CD", "BCM94350ZA", "BCM94352Z", "BCM94360CS", "BCM94360CSAX", "BCM943602CS", "BCM94360CS2", "BCM94360CD", "BCM943602CD", "BCM943602CDP"]
    private static let fenviCards: [String] = ["FV-HB1200", "AC1900", "FV-T919"]
    private static let tpLinkCards: [String] = ["Archer T6", "Archer T8E", "Archer T9E AC1900"]
    // vendor
    @State private var vendor: String = "Vendor"
    private static let vendorArray: [String] = ["Broadcom", "Fenvi", "TP-Link", "Apple", "USB"]
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
            Text("Wireless")
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
                                cardArray = WirelessPicker.tpLinkCards
                            } else if index == 3 || index == 4 {
                                cardDisabled = true
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
        status = "Support status: Unknown ❓"
        infoText = ""
        if vendorIndex == 0 { // broadcom
            if cardIndex == -1 {
                return
            } else if cardIndex == 0 { // BCM94331CD
                status = WirelessPicker.partialSupported
                infoText = "Natively supported up to macOS Mojave. Support can be forced into subsequent versions of macOS by force loading IO80211Family with OpenCore.\nSupported macOS version: macOS Mojave (10.14)"
            } else {
                status = WirelessPicker.partialSupported
                infoText = "Wi-Fi functionality will work out of the box, including in macOS Recovery. Bluetooth will require AirportBrcmFixup and BrcmPatchRAM, and may also require a USB map with the header your card is plugged into set to type 255.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
            }
        } else if vendorIndex == 1 { // fenvi
            if cardIndex == -1 {
                return
            } else if cardIndex == 0 || cardIndex == 2 { // HB1200, T919
                status = WirelessPicker.supported
                infoText = "Wi-Fi functionality will work out of the box, including in macOS Recovery. Bluetooth does not require any additional kexts because Fenvi uses genuine refurbished Apple cards for their products. It may, however, require a USB map with the header your card is plugged into set to type 255.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
            } else if cardIndex == 1 { // AC1900
                status = WirelessPicker.partialSupported
                infoText = "Wi-Fi functionality will work out of the box, including in macOS Recovery. Bluetooth is not supported on this card. This card is nearing the end of its life and may be dropped from a future version of macOS.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
            }
        } else if vendorIndex == 2 { // TP-Link
            if cardIndex == -1 {
                return
            } else if cardIndex == 0 || cardIndex == 1 {
                infoText = "Wi-Fi functionality will work out of the box, including in macOS Recovery. Bluetooth is not supported on this card.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
            } else {
                status = WirelessPicker.partialSupported
                infoText = "Wi-Fi functionality will work out of the box, including in macOS Recovery. Bluetooth is not supported on this card. This card is nearing the end of its life and may be dropped from a future version of macOS.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
            }
        } else if vendorIndex == 3 { // airport
            status = WirelessPicker.supported
            infoText = "Wi-Fi functionality will work out of the box, including in macOS Recovery. Bluetooth does not require any additional kexts, however it may require a USB map with the header your card is plugged into set to type 255. The only consideration with these is to make sure the Mac that the card is from supports the version of macOS you are installing."
        } else if vendorIndex == 4 { // usb
            status = WirelessPicker.possiblePartialSupported
            infoText = "If a USB Wi-Fi dongle advertises macOS support, it will work once macOS is installed, however it will not work in macOS Recovery. If it does not, check chris1111's Wireless-USB-Adapter repository on GitHub for information on dongles their software supports."
        }
    }
}

struct WirelessPicker_Previews: PreviewProvider {
    static var previews: some View {
        WirelessPicker()
    }
}
