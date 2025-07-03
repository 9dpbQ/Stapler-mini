//
//  KeyMetrics.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/08.
//
import SwiftUI

struct KeyMetrics {
    let unitSize: Double//1uなのか、1.25uなのか
    let baseSizeX: CGFloat // 1u のフレーム横方向の大きさ
    var baseSizeY: CGFloat { baseSizeX * 185 / 190 } // 実測値を元にした比率
    
    var frameWidth: CGFloat { baseSizeX * unitSize }
    var frameHeight: CGFloat { baseSizeY }
    
    var padding_keytop: CGFloat { baseSizeX * 10.5 / 190 }
    var round_keytop: CGFloat { baseSizeX * 15 / 190 }
    var enterSmallRound_keytop: CGFloat { baseSizeX * 12.5 / 190 }
    
    var fontSize_tap: CGFloat { baseSizeX * 50 / 190 }
    var fontSize_hold: CGFloat { baseSizeX * 120 / 190 }
    
   
    var padding_hilight: CGFloat { baseSizeX * 6.5 / 190 }
    var round_hilight: CGFloat { baseSizeX * 19 / 190 }
    var enterSmallRound_hilight: CGFloat { baseSizeX * 8.5 / 190 }
    
    var strokeWidth_hilight: CGFloat { baseSizeX * 4 / 190 }
    
    
    var addButtonWidth: CGFloat { padding_section }
    var buttonSpacerWidth: CGFloat { frameWidth - addButtonWidth }
    
    var padding_body: CGFloat { baseSizeX * 21 / 190 }
    var padding_section: CGFloat { baseSizeX * 21 / 190 }
    
    var round_body: CGFloat { baseSizeX * (21 + 10.5 + 15) / 190 } // Keytopと同心になるように
    
    
    var frame: CGSize {
        CGSize(
            width: baseSizeX * unitSize,
            height: baseSizeY
        )
    }
    var frame_keytop: CGSize {
        CGSize(
            width: frameWidth - (padding_keytop * 2),
            height: frameHeight - (padding_keytop * 2)
        )
    }
    var frame_hilight: CGSize {
        CGSize(
            width: frameWidth - (padding_hilight * 2),
            height: frameHeight - (padding_hilight * 2)
        )
    }
}
