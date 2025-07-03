//
//  USBInfoView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/10.
//

import SwiftUI


struct USBInfoView: View {
    @State private var usbInfo: String = ""
    
    var body: some View {
        ScrollView {
            Text(usbInfo)
                .font(.system(size: 10, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .textSelection(.enabled)
        }
        .onAppear {
            fetchUSBInfo()
//            fetchBluetoothInfo()
        }
    }
    
    func fetchUSBInfo() {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["system_profiler", "SPUSBDataType"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        
        do {
            try task.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                usbInfo = output
            }
        } catch {
            usbInfo = "Error executing command: \(error.localizedDescription)"
        }
    }
    
    //なんか表示されない。権限問題かな？
    //どうにもならないようなら「Bluetoothはここ」ボタンでも作ってターミナルで発火するようにしたり・・？
    
    func fetchBluetoothInfo() {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["system_profiler", "SPBluetoothDataType"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        
        do {
            try task.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                usbInfo = output
            }
        } catch {
            usbInfo = "Error executing command: \(error.localizedDescription)"
        }
    }
}


struct BluetoothInfoView: View {
    @State private var bluetoothInfo: String = ""

    var body: some View {
        ScrollView {
            Text(bluetoothInfo)
                .font(.system(size: 10, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            fetchBluetoothInfo()
        }
        .navigationTitle("Bluetooth Info")
    }

    func fetchBluetoothInfo() {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = ["system_profiler", "SPBluetoothDataType", "-detailLevel", "full"]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe

        do {
            try task.run()
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    bluetoothInfo = output
                }
            }
        } catch {
            DispatchQueue.main.async {
                bluetoothInfo = "Error executing command: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    USBInfoView()
}
