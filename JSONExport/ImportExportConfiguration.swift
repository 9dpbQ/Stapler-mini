//
//  ImportExportConfiguration.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/01/29.
//

import UniformTypeIdentifiers
import SwiftUI
import Foundation

func exportConfigurationAsJSON(_ configuration: Configuration) {
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = [.json]
    savePanel.nameFieldStringValue = "\(configuration.name).json"
    savePanel.begin { response in
        if response == .OK, let url = savePanel.url {
            do {
                let jsonData = try JSONEncoder().encode(configuration) // JSONにエンコード
                try jsonData.write(to: url) // ファイルに書き込み
                print("Preset saved to \(url)")
                NSWorkspace.shared.activateFileViewerSelecting([url])
            } catch {
                print("Failed to save preset: \(error)")
            }
        }
    }
}

import Compression

func loadConfiguration(completion: @escaping (Configuration?) -> Void) {
    
    let openPanel = NSOpenPanel()

    openPanel.allowedContentTypes = [UTType.zip, UTType.json]
    openPanel.begin { response in
        guard response == .OK, let url = openPanel.url else {
            completion(nil)
            return
        }
        
        do {
            let jsonData: Data
            
            if url.pathExtension == "zip" {
                jsonData = try extractJSONFromZip(at: url)
            } else {
                jsonData = try Data(contentsOf: url)
            }
            
            let loadedConfiguration = try JSONDecoder().decode(Configuration.self, from: jsonData)
            print("Preset loaded: \(loadedConfiguration)")
            completion(loadedConfiguration)
        } catch {
            print("Failed to load preset: \(error)")
            completion(nil)
        }
    }
}

func loadStoredConfig(storedConfig: StoredConfiguration, region: KeycodeRegion) -> Configuration? {
    if let fileURL = storedConfig.jsonFileURL(region) {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(Configuration.self, from: jsonData)
            
        } catch {
            print("Failed to load config: \(error)")
            return nil
        }
    } else {
        return nil
    }
}

/// アプリ内に格納されたZipファイルのパスを受け取ってConfigurationを返す関数
func loadInternalConfiguration(storedConfig: StoredConfiguration, region: KeycodeRegion) -> Configuration {
    
    if let fileURL: URL = storedConfig.jsonFileURL(region) {
        do {
            let jsonData = try extractJSONFromZip(at: fileURL)
            let loadedConfiguration = try JSONDecoder().decode(Configuration.self, from: jsonData)
            print("Internal configuration loaded for \(storedConfig): \(loadedConfiguration)")
            return loadedConfiguration
            
        } catch {
            print("Failed to load configuration for \(storedConfig): \(error)")
        }
    }
    return Configuration.initialConfig
}



// ZIPファイルを展開し、最初のJSONファイルを取得
func extractJSONFromZip(at url: URL) throws -> Data {
    let fileManager = FileManager.default
    let tempDir = fileManager.temporaryDirectory.appendingPathComponent(UUID().uuidString)

    try fileManager.createDirectory(at: tempDir, withIntermediateDirectories: true, attributes: nil)
    
    let unzipTask = Process()
    unzipTask.executableURL = URL(fileURLWithPath: "/usr/bin/unzip")
    unzipTask.arguments = ["-o", url.path, "-d", tempDir.path]
    
    try unzipTask.run()
    unzipTask.waitUntilExit()
    
    let files = try fileManager.contentsOfDirectory(at: tempDir, includingPropertiesForKeys: nil)
    if let jsonFile = files.first(where: { $0.pathExtension == "json" }) {
        return try Data(contentsOf: jsonFile)
    }
    
    throw NSError(domain: "No JSON file found in ZIP", code: 1, userInfo: nil)
}



