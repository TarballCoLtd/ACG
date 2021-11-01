//
//  GPUPicker.swift
//  ACG
//
//  Created by Alyx Ferrari on 10/28/21.
//

import SwiftUI

struct GPUPicker: View {
    // support constants
    private static let supported = "Support status: Natively supported ✅"
    private static let possibleSupported = "Support status: May be supported ⚠️"
    private static let partialSupported = "Support status: Partially supported ⚠️"
    private static let possiblePartialSupported = "Support status: May be partially supported ⚠️"
    private static let unsupported = "Support status: Unsupported ❌"
    // generation constants
    private static let amdGenerations: [String] = ["Polaris - RX 400 & 500 series", "Navi - RX 5000 series", "Big Navi - RX 6000 series", "Vega"]
    private static let nvidiaGenerations: [String] = ["Kepler - GTX 700 series", "Maxwell - GTX 900 series", "Pascal - GTX 10 series", "Turing - GTX 16 series", "Turing - RTX 20 series", "Ampere - RTX 30 series"]
    // amd generation cards
    private static let polarisCards: [String] = ["RX 460", "RX 470", "RX 480", "RX 550", "RX 560", "RX 570", "RX 580", "RX 590"]
    private static let naviCards: [String] = ["RX 5500", "RX 5500 XT", "RX 5600", "RX 5600 XT", "RX 5700", "RX 5700 XT"]
    private static let bigNaviCards: [String] = ["RX 6600", "RX 6600 XT", "RX 6700 XT", "RX 6800", "RX 6800 XT", "RX 6900 XT"]
    private static let vegaCards: [String] = ["Vega 8", "Vega 11", "Vega 56", "Vega 64", "Radeon VII"]
    // nvidia generation cards
    private static let keplerCards: [String] = ["GT 710", "GT 720", "GT 730", "GT 740", "GTX 745", "GTX 750", "GTX 750 Ti", "GTX 760", "GTX 760 Ti", "GTX 770", "GTX 780", "GTX 780 Ti", "GTX Titan", "GTX Titan Z"]
    private static let maxwellCards: [String] = ["GTX 950", "GTX 960", "GTX 970", "GTX 980", "GTX 980 Ti", "GTX Titan X"]
    private static let pascalCards: [String] = ["GT 1010", "GT 1030", "GTX 1050", "GTX 1050 Ti", "GTX 1060", "GTX 1070", "GTX 1070 Ti", "GTX 1080", "GTX 1080 Ti", "GTX Titan X", "GTX Titan Xp"]
    private static let turing16Cards: [String] = ["GTX 1650", "GTX 1650 SUPER", "GTX 1660", "GTX 1660 SUPER", "GTX 1660 Ti"]
    private static let turing20Cards: [String] = ["RTX 2060", "RTX 2060 SUPER", "RTX 2070", "RTX 2070 SUPER", "RTX 2080", "RTX 2080 SUPER", "RTX 2080 Ti", "Titan RTX"]
    private static let ampereCards: [String] = ["RTX 3060", "RTX 3060 Ti", "RTX 3070", "RTX 3070 Ti", "RTX 3080", "RTX 3080 Ti", "RTX 3090"]
    // vendor
    @State private var vendor: String = "Vendor"
    @State private var vendorArray: [String] = ["AMD", "NVIDIA"]
    // generation
    @State private var generation: String = "Generation"
    @State private var generationDisabled: Bool = true
    @State private var generationArray: [String] = []
    // card name
    @State private var card: String = "Card"
    @State private var cardDisabled: Bool = true
    @State private var cardArray: [String] = []
    // states
    @State private var vendorIndex: Int = -1
    @State private var generationIndex: Int = -1
    @State private var cardIndex: Int = -1
    // status vars
    @State private var status: String = "Support status: Unknown ❓"
    @State private var infoText: String = "None"
    @State private var infoState: Bool = false
    @State private var infoButtonText: String = "More info"
    @State private var infoButtonState: Bool = false
    var body: some View {
        VStack {
            HStack {
                Menu(vendor) {
                    ForEach(Array(vendorArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            generation = "Generation"
                            card = "Card"
                            generationDisabled = false
                            cardDisabled = true
                            if index == 0 {
                                vendor = "AMD"
                                generationArray = GPUPicker.amdGenerations
                            } else if index == 1 {
                                vendor = "NVIDIA"
                                generationArray = GPUPicker.nvidiaGenerations
                            }
                            vendorIndex = index
                            generationIndex = -1
                            cardIndex = -1
                            genStatus()
                        }
                    }
                }
                Menu(generation) {
                    ForEach(Array(generationArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            generation = element.components(separatedBy: " - ")[0]
                            card = "Card"
                            cardDisabled = false
                            if vendor == "AMD" {
                                if index == 0 {
                                    cardArray = GPUPicker.polarisCards
                                } else if index == 1 {
                                    cardArray = GPUPicker.naviCards
                                } else if index == 2 {
                                    cardArray = GPUPicker.bigNaviCards
                                } else if index == 3 {
                                    cardArray = GPUPicker.vegaCards
                                }
                            } else if vendor == "NVIDIA" {
                                if index == 0 {
                                    cardArray = GPUPicker.keplerCards
                                } else if index == 1 {
                                    cardArray = GPUPicker.maxwellCards
                                } else if index == 2 {
                                    cardArray = GPUPicker.pascalCards
                                } else if index == 3 {
                                    cardArray = GPUPicker.turing16Cards
                                } else if index == 4 {
                                    cardArray = GPUPicker.turing20Cards
                                } else if index == 5 {
                                    cardArray = GPUPicker.ampereCards
                                }
                            }
                            generationIndex = index
                            cardIndex = -1
                            genStatus()
                        }
                    }
                }.disabled(generationDisabled)
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
                Text(infoState ? "\(status)\n\(infoText)" : status)
                Spacer()
            }
            HStack {
                Button(infoButtonText) {
                    infoButtonState = !infoButtonState
                    infoState = !infoState
                    if infoButtonState {
                        infoButtonText = "Less info"
                    } else {
                        infoButtonText = "More info"
                    }
                }
                .buttonStyle(.plain)
                .foregroundColor(.blue)
                Spacer()
            }
        }
    }
    private func genStatus() {
        status = "Support status: Unknown ❓"
        infoText = "None"
        if vendorIndex == 0 { // AMD
            if generationIndex == 0 { // polaris
                if cardIndex == -1 {
                    return
                } else if cardIndex == 3 { // RX 550
                    status = GPUPicker.possibleSupported
                    infoText = "This card will only work with a Baffin core variant. Lexa core models are not supported. You can check this in GPU-Z on Windows.\nSupported macOS versions: macOS Sierra (10.12) to macOS Monterey (12)"
                } else { // everything else
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. It will work out of the box with no configuration.\nSupported macOS versions: macOS Sierra (10.12) to macOS Monterey (12)"
                }
            } else if generationIndex == 1 { // navi
                if cardIndex == -1 {
                    return
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You may need WhateverGreen and the agdpmod=pikera boot argument to boot.\nSupported macOS versions: macOS Catalina (10.15) to macOS Monterey (12)"
                }
            } else if generationIndex == 2 { // big navi
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 2 { // RX 6600 & 6700 XT
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else if cardIndex == 5 { // RX 6900 XT
                    status = GPUPicker.possibleSupported
                    infoText = "This card will only work if it is an XTX variant. XTXH variants of this card are not supported. This can be worked around by flashing an XTX VBIOS. Usually only special edition liquid cooled cards are XTXH variants. You may need WhateverGreen and the agdpmod=pikera boot argument to boot.\nSupported macOS versions: macOS Big Sur (11) to macOS Monterey (12)"
                } else if cardIndex == 1 {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You may need WhateverGreen and the agdpmod=pikera boot argument to boot.\nSupported macOS versions: macOS Big Sur (11) to macOS Monterey (12)"
                } else { // everything else
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You may need WhateverGreen and the agdpmod=pikera boot argument to boot.\nSupported macOS versions: macOS Monterey (12)"
                }
            } else if generationIndex == 3 { // vega
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 1 { // APUs
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else if cardIndex == 2 || cardIndex == 3 { // vega 10
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. It will work out of the box with no configuration.\nSupported macOS versions: macOS High Sierra (10.13) to macOS Monterey (12)"
                } else { // vega 20
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. It will work out of the box with no configuration.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
                }
            }
        } else if vendorIndex == 1 { // NVIDIA
            if generationIndex == 0 { // kepler
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 2 { // GT 710 & 730
                    status = GPUPicker.possiblePartialSupported
                    infoText = "This card will only work with a GK208 core. Any other core is not supported. You can check this in GPU-Z on Windows. Support for Kepler was dropped in macOS Monterey.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Big Sur (11)"
                } else if cardIndex == 1 { // GT 720
                    status = GPUPicker.partialSupported
                    infoText = "This card is natively supported by macOS's drivers up to macOS Big Sur. Support for Kepler was dropped in macOS Monterey.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Big Sur (11)"
                } else if cardIndex == 3 { // GT 740
                    status = GPUPicker.possiblePartialSupported
                    infoText = "This card will only work with a GK107 core. Any other core is not supported. You can check this in GPU-Z on Windows. Support for Kepler was dropped in macOS Monterey.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Big Sur (11)"
                } else if cardIndex == 4 || cardIndex == 5 || cardIndex == 6 { // maxwell
                    status = GPUPicker.partialSupported
                    infoText = "This card is supported with NVIDIA's web drivers up to macOS High Sierra. Despite being part of the GTX 700 series, this card is Maxwell based, not Kepler. As such, you will be limited to macOS High Sierra and will need NVIDIA's web drivers to use this card.\nSupported macOS versions: macOS Sierra (10.12) to macOS High Sierra (10.13)"
                } else if cardIndex == 7 || cardIndex == 8 || cardIndex == 9 || cardIndex == 10 || cardIndex == 11 {
                    status = GPUPicker.partialSupported
                    infoText = "This card is natively supported by macOS's drivers up to macOS Big Sur. Support for Kepler was dropped in macOS Monterey.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Big Sur (11)"
                } else if cardIndex == 12 { // titan
                    status = GPUPicker.possiblePartialSupported
                    infoText = "This card will only work with a GK110 core. Any other core is not supported. You can check this in GPU-Z on Windows. Support for Kepler was dropped in macOS Monterey.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Big Sur (11)"
                } else { // titan Z
                    status = GPUPicker.partialSupported
                    infoText = "This card is natively supported by macOS's drivers up to macOS Big Sur. Support for Kepler was dropped in macOS Monterey. Although this is a dual GPU card, only one GPU will be in use.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Big Sur (11)"
                }
            } else if generationIndex == 1 { // maxwell
                if cardIndex == -1 {
                    return
                } else if cardIndex == 5 { // titan X
                    status = GPUPicker.possiblePartialSupported
                    infoText = "This card is supported with NVIDIA's web drivers up to macOS High Sierra. This card will only work with a GK110 core. Any other core is not supported. You can check this in GPU-Z on Windows.\nSupported macOS versions: Mac OS X Yosemite (10.10) to macOS High Sierra (10.13)"
                } else {
                    status = GPUPicker.partialSupported
                    infoText = "This card is supported with NVIDIA's web drivers up to macOS High Sierra.\nSupported macOS versions: Mac OS X Yosemite (10.10) to macOS High Sierra (10.13)"
                }
            } else if generationIndex == 2 { // pascal
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 1 || cardIndex == 2 || cardIndex == 3 {
                    status = GPUPicker.partialSupported
                    infoText = "This card is supported with NVIDIA's web drivers up to macOS High Sierra.\nSupported macOS versions: macOS Sierra (10.12) to macOS High Sierra (10.13)"
                } else if cardIndex == 4 {
                    status = GPUPicker.possiblePartialSupported
                    infoText = "This card will only work with the GDDR5 variant, the GDDR5X variant is not supported. This card is supported with NVIDIA's web drivers up to macOS High Sierra.\nSupported macOS versions: macOS Sierra (10.12) to macOS High Sierra (10.13)"
                } else if cardIndex == 9 || cardIndex == 10 {
                    status = GPUPicker.possiblePartialSupported
                    infoText = "This card will only work with a GP102 core. All other cores are not supported. You can check this in GPU-Z on Windows. This card is supported with NVIDIA's web drivers up to macOS High Sierra.\nSupported macOS versions: macOS Sierra (10.12) to macOS High Sierra (10.13)"
                } else {
                    status = GPUPicker.partialSupported
                    infoText = "This card is supported with NVIDIA's web drivers up to macOS High Sierra.\nSupported macOS versions: macOS Sierra (10.12) to macOS High Sierra (10.13)"
                }
            } else if generationIndex == 3 { // turing 16
                if cardIndex == -1 {
                    return
                } else {
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                }
            } else if generationIndex == 4 { // turing 20
                if cardIndex == -1 {
                    return
                } else {
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                }
            } else if generationIndex == 5 { // ampere
                if cardIndex == -1 {
                    return
                } else {
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                }
            }
        }
    }
}

struct GPUPicker_Previews: PreviewProvider {
    static var previews: some View {
        GPUPicker()
    }
}
