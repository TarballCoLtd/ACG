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
    private static let intelGenerations: [String] = ["Ivy Bridge - 3rd gen", "Haswell - 4th gen", "Broadwell - 5th gen", "Skylake - 6th gen", "Kaby Lake - 7th gen", "Coffee/Comet/Ice Lake - 8th, 9th, & 10th gen", "Rocket Lake - 11th gen"]
    // amd generation cards
    private static let polarisCards: [String] = ["RX 460", "RX 470", "RX 480", "RX 550", "RX 560", "RX 570", "RX 580", "RX 590"]
    private static let naviCards: [String] = ["RX 5500", "RX 5500 XT", "RX 5600", "RX 5600 XT", "RX 5700", "RX 5700 XT"]
    private static let bigNaviCards: [String] = ["RX 6600", "RX 6600 XT", "RX 6700 XT", "RX 6800", "RX 6800 XT", "RX 6900 XT"]
    private static let vegaCards: [String] = ["Vega 8", "Vega 11", "Vega 56", "Vega 64", "Radeon VII"]
    // nvidia generation cards
    private static let keplerCards: [String] = ["GT 710", "GT 720", "GT 730", "GT 740", "GTX 745", "GTX 750", "GTX 750 Ti", "GTX 760", "GTX 760 Ti", "GTX 770", "GTX 780", "GTX 780 Ti", "GTX Titan", "GTX Titan Z"]
    private static let maxwellCards: [String] = ["GTX 950", "GTX 960", "GTX 970", "GTX 980", "GTX 980 Ti", "GTX Titan X"]
    private static let pascalCards: [String] = ["GT 1010", "GT 1030", "GTX 1050", "GTX 1050 Ti", "GTX 1060", "GTX 1070", "GTX 1070 Ti", "GTX 1080", "GTX 1080 Ti", "GTX Titan X", "GTX Titan Xp"]
    // intel generation cards
    private static let ivyBridgeCards: [String] = ["HD 2500", "HD 4000", "HD P4000"]
    private static let haswellCards: [String] = ["HD 4200", "HD 4400", "HD 4600", "HD P4600", "HD P4700", "HD 5000", "HD 5100"]
    private static let broadwellCards: [String] = ["HD 5300", "HD 5500", "HD 5600", "HD P5700", "HD 6000", "HD 6100", "HD 6200", "Iris Pro P6300"]
    private static let skylakeCards: [String] = ["HD 510", "HD 515", "HD 520", "HD 530", "HD P530", "Iris 540", "Iris 550", "Iris Pro P555", "Iris Pro 580", "Iris Pro P580"]
    private static let kabyLakeCards: [String] = ["HD 610", "HD 615", "HD 620", "HD 630", "Iris Plus 640", "Iris Plus 650"]
    private static let coffeeCometIceCards: [String] = ["UHD 610", "UHD 615", "UHD 617", "UHD 620", "UHD 630", "Iris Plus 645", "Iris Plus 655", "Iris Plus G4", "Iris Plus G7", "Iris Xe"]
    private static let rocketLakeCards: [String] = ["UHD 730", "UHD 750", "UHD P750"]
    // vendor
    @State private var vendor: String = "Vendor"
    private let vendorArray: [String] = ["AMD", "NVIDIA", "Intel"]
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
    var body: some View {
        VStack {
            Text("GPU")
            HStack {
                Menu(vendor) {
                    ForEach(Array(vendorArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            generation = "Generation"
                            card = "Card"
                            generationDisabled = false
                            cardDisabled = true
                            vendor = element
                            if index == 0 {
                                generationArray = GPUPicker.amdGenerations
                            } else if index == 1 {
                                generationArray = GPUPicker.nvidiaGenerations
                            } else if index == 2 {
                                generationArray = GPUPicker.intelGenerations
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
                            if vendorIndex == 0 {
                                if index == 0 {
                                    cardArray = GPUPicker.polarisCards
                                } else if index == 1 {
                                    cardArray = GPUPicker.naviCards
                                } else if index == 2 {
                                    cardArray = GPUPicker.bigNaviCards
                                } else if index == 3 {
                                    cardArray = GPUPicker.vegaCards
                                }
                            } else if vendorIndex == 1 {
                                if index == 0 {
                                    cardArray = GPUPicker.keplerCards
                                } else if index == 1 {
                                    cardArray = GPUPicker.maxwellCards
                                } else if index == 2 {
                                    cardArray = GPUPicker.pascalCards
                                }
                            } else if vendorIndex == 2 {
                                if index == 0 {
                                    cardArray = GPUPicker.ivyBridgeCards
                                } else if index == 1 {
                                    cardArray = GPUPicker.haswellCards
                                } else if index == 2 {
                                    cardArray = GPUPicker.broadwellCards
                                } else if index == 3 {
                                    cardArray = GPUPicker.skylakeCards
                                } else if index == 4 {
                                    cardArray = GPUPicker.kabyLakeCards
                                } else if index == 5 {
                                    cardArray = GPUPicker.coffeeCometIceCards
                                } else if index == 6 {
                                    cardArray = GPUPicker.rocketLakeCards
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
                    infoState = !infoState
                    if infoState {
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
                    infoText = "This card will only work with a Baffin core variant. Lexa core models are not supported. You can check this in GPU-Z on Windows. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Sierra (10.12) to macOS Monterey (12)"
                } else { // everything else
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. It will work out of the box with no configuration. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Sierra (10.12) to macOS Monterey (12)"
                }
            } else if generationIndex == 1 { // navi
                if cardIndex == -1 {
                    return
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You may need WhateverGreen and the agdpmod=pikera boot argument to boot. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Catalina (10.15) to macOS Monterey (12)"
                }
            } else if generationIndex == 2 { // big navi
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 2 { // RX 6600 & 6700 XT
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else if cardIndex == 5 { // RX 6900 XT
                    status = GPUPicker.possibleSupported
                    infoText = "This card will only work if it is an XTX variant. XTXH variants of this card are not supported. This can be worked around by flashing an XTX VBIOS. Usually only special edition liquid cooled cards are XTXH variants. You may need WhateverGreen and the agdpmod=pikera boot argument to boot. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Big Sur (11) to macOS Monterey (12)"
                } else if cardIndex == 1 {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You may need WhateverGreen and the agdpmod=pikera boot argument to boot. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Big Sur (11) to macOS Monterey (12)"
                } else { // everything else
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You may need WhateverGreen and the agdpmod=pikera boot argument to boot. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Monterey (12)"
                }
            } else if generationIndex == 3 { // vega
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 1 { // APUs
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else if cardIndex == 2 || cardIndex == 3 { // vega 10
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. It will work out of the box with no configuration. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS High Sierra (10.13) to macOS Monterey (12)"
                } else { // vega 20
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. It will work out of the box with no configuration. Use Shaneee's PAT patch for a significant GPU performance boost.\nSupported macOS versions: macOS Mojave (10.14) to macOS Monterey (12)"
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
            } else if generationIndex == 3 || generationIndex == 4 || generationIndex == 5 { // turing 16
                status = GPUPicker.unsupported
                infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                cardDisabled = true
            }
        } else if vendorIndex == 2 { // intel
            if generationIndex == 0 { // ivy bridge
                if cardIndex == -1 {
                    return
                } else {
                    status = GPUPicker.partialSupported
                    infoText = "This card is natively supported by macOS's drivers up to macOS Catalina. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: Mac OS X Lion (10.7) to macOS Catalina (10.15)"
                }
            } else if generationIndex == 1 { // haswell
                if cardIndex == -1 {
                    return
                } else if cardIndex == 3 || cardIndex == 4 { // HD P4600 & P4700
                    status = GPUPicker.possibleSupported
                    infoText = "This card is theoretically natively supported, however support has not been confirmed. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Monterey (12)"
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: Mac OS X Mountain Lion (10.8) to macOS Monterey (12)"
                }
            } else if generationIndex == 2 { // broadwell
                if cardIndex == -1 {
                    return
                } else if cardIndex == 3 { // HD P5700
                    status = GPUPicker.possibleSupported
                    infoText = "This card is theoretically natively supported, however support has not been confirmed. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: Mac OS X Yosemite (10.10) to macOS Monterey (12)"
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: Mac OS X Yosemite (10.10) to macOS Monterey (12)"
                }
            } else if generationIndex == 3 { // skylake
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 { // HD 510
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: Mac OS X El Capitan (10.11) to macOS Monterey (12)"
                }
            } else if generationIndex == 4 { // kaby lake
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 { // HD 610
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: macOS Sierra (10.12) to macOS Monterey (12)"
                }
            } else if generationIndex == 5 { // coffee/comet/ice lake
                if cardIndex == -1 {
                    return
                } else if cardIndex == 0 || cardIndex == 9 {
                    status = GPUPicker.unsupported
                    infoText = "This card is not supported in any version of macOS. You may be able to boot with this card, but you will have no GPU acceleration. This means that macOS will be extremely laggy and you will experience artifacting and glitching. In addition, nothing 3D accelerated will work."
                } else {
                    status = GPUPicker.supported
                    infoText = "This card is natively supported by macOS's drivers. You will need WhateverGreen and framebuffer patches to get this card working.\nSupported macOS versions: macOS Catalina (10.15) to macOS Monterey (12)"
                }
            } else if generationIndex == 6 { // rocket lake
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
