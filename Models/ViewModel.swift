//
//  ViewModel.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/08.
//
import SwiftUI

///ViewModel
///環境変数として複数のビューに渡し、
///この中の変数を元にPresetView、サイドバーのビューなどの状態を切り分ける
///ゆくゆくはアプリを閉じたときもその状態を保存しておきたいのは山々後回しかな
final class ViewModel: ObservableObject {
    @Published var configuration: Configuration
    @Published var keyboardMonitor: KeyboardMonitor
//    @Published var configurationType: ConfigurationType
    var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: configuration.displayKeySize)
    }
    init() {
        self.configuration = .initialConfig
        self.keyboardMonitor = KeyboardMonitor()
//        self.configurationType = .userConfiguration
    }
}


//enum ConfigurationType: CaseIterable {
//    
//    case userConfiguration
//    // 以下は全ての配列とサンプル設定など。で、UKUSJISのレイアウトを渡してすぐ使えるようにするか〜めんどくさいけども。
//    case oonishiLayout
//    case onik
//    // etc...
//
//    // デフォルトのファイルURLを返すメソッドを追加
//    func fileURL() -> URL {
//        let defaultURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Documents/default.json.zip")
//
//        switch self {
//        case .userConfiguration:
//            return Bundle.main.url(forResource: "oonishi", withExtension: "zip", subdirectory: "StoredConfiguration") ?? defaultURL
//        case .oonishiLayout:
//            return Bundle.main.url(forResource: "oonishi.json", withExtension: "zip") ?? defaultURL
//        case .onik:
//            return Bundle.main.url(forResource: "onik.json", withExtension: "zip", subdirectory: "StoredConfiguration") ?? defaultURL
//        }
//    }
//}

