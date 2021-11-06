//
//  CPUPicker.swift
//  ACG
//
//  Created by Alyx Ferrari on 11/5/21.
//

import SwiftUI

struct CPUPicker: View {
    // support constants
    private static let supported = "Support status: Supported ✅"
    private static let partialSupported = "Support status: Partially supported ⚠️"
    private static let unsupported = "Support status: Unsupported ❌"
    // amd generations
    private static let amdDesktopGenerations: [String] = ["Bulldozer - FX", "Jaguar - Athlon 5000 series", "Zen - Ryzen & Threadripper", "Other"]
    // vendor
    @State private var vendor: String = "Vendor"
    // type
    @State private var type: String = "Type"
    @State private var typeDisabled: Bool = true
    private static let typeArray: [String] = ["Desktop", "Mobile"]
    // generation
    @State private var generation: String = "Generation"
    @State private var generationDisabled: Bool = true
    @State private var generationArray: [String] = []
    // states
    @State private var vendorIndex: Int = -1
    @State private var typeIndex: Int = -1
    @State private var generationIndex: Int = -1
    // status vars
    @State private var status: String = "Support status: Unknown ❓"
    @State private var infoState: Bool = false
    @State private var infoText: String = "None"
    @State private var infoButtonText: String = "More info"
    var body: some View {
        VStack {
            Text("CPU")
            HStack {
                Menu(vendor) {
                    Button("AMD") {
                        vendorIndex = 0
                        typeIndex = -1
                        generationIndex = -1
                        vendor = "AMD"
                        type = "Type"
                        generation = "Generation"
                        typeDisabled = false
                        generationDisabled = true
                        genStatus()
                    }
                    Text("Intel")
                }
                Menu(type) {
                    ForEach(Array(CPUPicker.typeArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            generationDisabled = false
                            generationIndex = -1
                            generation = "Generation"
                            type = element
                            typeIndex = index
                            if index == 0 {
                                generationArray = CPUPicker.amdDesktopGenerations
                            } else {
                                generationArray = []
                                generationDisabled = true
                            }
                            genStatus()
                        }
                    }
                }.disabled(typeDisabled)
                Menu(generation) {
                    ForEach(Array(generationArray.enumerated()), id: \.element) { index, element in
                        Button(element) {
                            generation = element.components(separatedBy: " - ")[0]
                            generationIndex = index
                            genStatus()
                        }
                    }
                }.disabled(generationDisabled)
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
            if typeIndex == 0 { // desktop
                if generationIndex == -1 {
                    return
                } else if generationIndex == 0 || generationIndex == 1 {
                    status = CPUPicker.partialSupported
                    infoText = "This CPU is supported in macOS with the AMD OS X patches. macOS 12.1 requires RDRAND support, which these CPUs lack; there is currently no fix. Using versions of macOS older than High Sierra is not possible without a custom kernel.\nSupported macOS versions: macOS High Sierra (10.13) to macOS Monterey (12)"
                } else if generationIndex == 3 {
                    status = CPUPicker.unsupported
                    infoText = "This CPU is not supported by the AMD OS X patches. Using this CPU requires a custom kernel."
                } else {
                    status = CPUPicker.supported
                    infoText = "This CPU is supported in macOS with the AMD OS X patches. The Ryzen Threadripper 3990X requires SMT disabled in the BIOS because macOS's kernel only supports up to 64 threads. Using versions of macOS older than High Sierra is not possible without a custom kernel.\nSupported macOS versions: macOS High Sierra (10.13) to macOS Monterey (12)"
                }
            } else if typeIndex == 1 { // laptop
                status = CPUPicker.unsupported
                infoText = "While the CPU itself is supported with the AMD OS X patches, both dedicated and integrated mobile GPUs are completely unsupported on AMD laptops, meaning there is no overall support for them."
            }
        }
    }
}

struct CPUPicker_Previews: PreviewProvider {
    static var previews: some View {
        CPUPicker()
    }
}
