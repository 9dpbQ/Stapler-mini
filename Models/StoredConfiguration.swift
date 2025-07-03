//
//  StoredConfiguration.swift
//  Stapler-mini
//
//  Created by qdpb on 2025/04/14.
//
import SwiftUI

enum StoredConfiguration: CaseIterable {
    case onishi, onik, wakasagi, astarte, eucalyn, m_shiki, dvorakJP // 日英
    case mtgap, colemak, workman, dvorak, poqtea, uciea_vanilla // English
    case layerSample
//    case sampleLayer, developpersSetting // Layerとかのサンプルみたいな
    
    
    // タイトル的な
    func configurationTitle() -> String {
        switch self {
        case .onishi: "Onishi"
        case .onik: "onik"
        case .wakasagi: "Wakasagi"
        case .astarte: "Astarte"
        case .eucalyn: "Eucalyn"
        case .m_shiki: "M shiki"
        case .dvorakJP: "DvorakJP"
            
        case .mtgap: "MTGAP"
        case .colemak: "Colemak"
        case .workman: "Workman"
        case .dvorak: "Dvorak"
        case .poqtea: "poqtea qp"
        case .uciea_vanilla: "Uciea Vanilla"
            
        case .layerSample: "Layer Sample"
        }
    }
    
    func fileName(_ region: KeycodeRegion) -> String {
        let  reg = "_" + region.layoutName()
        let layout: String
        switch self {
        case .onishi: layout = "Onishi"
        case .onik: layout = "onik"
        case .wakasagi: layout = "Wakasagi"
        case .astarte: layout = "Astarte"
        case .eucalyn: layout = "Eucalyn"
        case .m_shiki: layout = "M_Shiki"
        case .dvorakJP: layout = "DvorakJP"
            
        case .mtgap: layout = "MTGAP"
        case .colemak: layout = "Colemak"
        case .workman: layout = "Workman"
        case .dvorak: layout = "Dvorak"
        case .poqtea: layout = "poqtea_qp"
        case .uciea_vanilla: layout = "Uciea_vanilla"
            
        case .layerSample: layout = "LayerSample"
        }
        return layout + reg
    }
    
    /// 自身とキーボードのリージョンからファイルパスを返す関数
    func jsonFileURL(_ region: KeycodeRegion) -> URL? {
        return Bundle.main.url(forResource: self.fileName(region), withExtension: "json")
    }
    
    /// 自身とキーボードのリージョンから画像ファイル名を返す関数
    func imageFileURL(_ region: KeycodeRegion) -> String {
        return self.fileName(region)
    }
    
    /// 自身から引用URLの文字列を返す関数
    func webURL() -> String {
        switch self {
        case .onishi: "https://o24.works/layout/"
        case .onik: "https://note.com/oidy/n/n506216439bdd"
        case .wakasagi: "https://zenn.dev/paalon/articles/1210b06f636c66"
        case .astarte: "https://neinvalli.hatenablog.com/entry/2018/07/21/185448"
        case .eucalyn: "https://eucalyn.hatenadiary.jp/entry/about-eucalyn-layout"
        case .m_shiki: "https://ameblo.jp/mshikiworld/entry-11234829455.html"
        case .dvorakJP: "https://web.archive.org/web/20211118214746/http://www7.plala.or.jp/dvorakjp/dvorakjp.htm"
        case .mtgap: "https://github.com/kenranunderscore/mtgap-layout"
        case .colemak: "https://colemak.com/"
        case .workman: "https://workmanlayout.org/"
        case .dvorak: "https://dvorak-keyboard.com/"
        case .poqtea: "https://www.keyboard-design.com/letterlayout.html?layout=poqtea-qp.en.ansi"
        case .uciea_vanilla: "https://www.keyboard-design.com/letterlayout.html?layout=uciea-vanilla.en.ansi"
            
        case .layerSample: "https://github.com/9dpbQ/Stapler-mini"
        }
    }
    
    
    
    func linkLabel() -> String {
        switch self {
        case .onishi:
            "『大西配列』は、タイピングが苦手な人のための新しいキーボード配列です。日本人がローマ字をもっとも入力しやすいように100万字の統計から開発され、QWERTY配列と比べて指の移動距離は約52%、同じ指の連続は約88%減少します。"
        case .onik:
            "日本語が打ちやすいキー配列を作りました/onik"
        default:
            "test"
        }
    }
    
}
