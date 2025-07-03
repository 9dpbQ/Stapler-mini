//
//  StoredMacroView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//

import SwiftUI

struct StoredMacroView_JP_hiragana: View {
    var body: some View {
        List {
            Section("Japanese") {
                StoredMacroView_JP_seion()
                StoredMacroView_JP_dakuon()
                StoredMacroView_JP_youon()
            }
            Section("Symbols") {
                StoredMacroView_SymbolSeaquences()
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct StoredMacroView_SymbolSeaquences: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 45)
    }
    private var spacerView: some View {
        Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.symbolsAndArrowMacros["[]"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.symbolsAndArrowMacros["{}"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.symbolsAndArrowMacros["()"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.symbolsAndArrowMacros["''"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.symbolsAndArrowMacros["\"\""], sizeX: keyMetrics.baseSizeX)
            }
            HStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.programingMacros["+="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["-="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["*="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["/="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["%="], sizeX: keyMetrics.baseSizeX)
                
                MacroKeyView(StoredMacroDictionary.programingMacros["=="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["!="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros[">="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["<="], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["&&"], sizeX:keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["||"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["->"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.programingMacros["<-"], sizeX: keyMetrics.baseSizeX)

            }
        }
    }
}

struct StoredMacroView_JP_seion: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 45)
    }
    private var spacerView: some View {
        Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
    }
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ん"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["っ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                spacerView
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["わ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                spacerView
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["を"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ら"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["り"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["る"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["れ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ろ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["や"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゆ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["よ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ま"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["み"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["む"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["め"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["も"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["は"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ひ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ふ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["へ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ほ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["な"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["に"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぬ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ね"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["の"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["た"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ち"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["つ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["て"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["と"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["さ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["し"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["す"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["せ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["そ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["か"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["き"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["く"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["け"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["こ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["あ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["い"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["う"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["え"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["お"], sizeX: keyMetrics.baseSizeX)
            }
        }
    }
}

struct StoredMacroView_JP_dakuon: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 45)
    }
    private var spacerView: some View {
        Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
    }
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぱ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぴ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぷ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぺ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぽ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ば"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["び"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぶ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["べ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぼ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["だ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぢ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["づ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["で"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ど"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ざ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["じ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ず"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぜ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぞ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["が"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぎ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぐ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["げ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ご"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゔぁ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゔぃ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゔ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゔぇ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゔぉ"], sizeX: keyMetrics.baseSizeX)
            }
        }
    }
}

struct StoredMacroView_JP_youon: View {
    @EnvironmentObject private var viewModel: ViewModel
    private var keyMetrics: KeyMetrics {
        KeyMetrics(unitSize: 1, baseSizeX: 45)
    }
    private var spacerView: some View {
        Spacer().frame(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
    }
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["りゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["りゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["りょ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["みゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["みゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["みょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ふぁ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ふぃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ふぇ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ふぉ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぴゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぴゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぴょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["びゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["びゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["びょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ひゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ひゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ひょ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["にゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["にゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["にょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["どぅ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["でぃ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["でゅ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["でぇ"], sizeX: keyMetrics.baseSizeX)
                spacerView
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["とぅ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["てぃ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["とぅ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["てぇ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["てょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぢゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぢゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぢょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ちゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ちゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ちょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["じゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["じゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["じょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["しゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["しゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["しょ"], sizeX: keyMetrics.baseSizeX)
            }
            
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぎゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぎゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぎょ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["きゃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["きゅ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["きょ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["うぃ"], sizeX: keyMetrics.baseSizeX)
                spacerView
                MacroKeyView(StoredMacroDictionary.kanaMacros["うぇ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["うぉ"], sizeX: keyMetrics.baseSizeX)
            }
            VStack(spacing: 0) {
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぁ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぃ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぅ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぇ"], sizeX: keyMetrics.baseSizeX)
                MacroKeyView(StoredMacroDictionary.kanaMacros["ぉ"], sizeX: keyMetrics.baseSizeX)
            }
        }
    }
}
