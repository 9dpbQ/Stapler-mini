//
//  KeyShape.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/16.
//
import SwiftUI
import SwiftData

enum KeyShape: String, CaseIterable, Codable {
    case square
    case enter_JIS
    case enter_UK
    case enter_Tenkey
    case arrow_Up
    case arrow_Down
    case arrow_LR
    
    
    var isArrows: Bool {
        return self == .arrow_Up || self == .arrow_Down || self == .arrow_LR
    }
    
    func handleShapeChanged() -> Double? {
        switch self {
        case .square: nil
        case .enter_JIS: 1.5
        default : 1.0
        }
    }
    
    func alignment() -> Alignment {
        switch self {
        case .arrow_Up: return Alignment.bottom
        case .arrow_Down: return Alignment.top
        default: return Alignment.center
        }
    }
        
    func keytopShape(_ keyMetrics: KeyMetrics) -> AnyShape {
        switch self {
        case .enter_JIS:
            AnyShape(KeytopShape_JIS(keyMetrics: keyMetrics))
        case .enter_UK:
            AnyShape(KeytopShape_UK(keyMetrics: keyMetrics))
        case .arrow_Up:
            AnyShape(KeytopShape_ArrowUp(keyMetrics: keyMetrics))
        case .arrow_Down:
            AnyShape(KeytopShape_ArrowDown(keyMetrics: keyMetrics))
        default:
            AnyShape(RoundedRectangle(cornerRadius: keyMetrics.round_keytop))
        }
    }
    
        
    func hilightShape(_ keyMetrics: KeyMetrics) -> AnyShape {
        switch self {
        case .enter_JIS:
            AnyShape(HilightShape_JIS(keyMetrics: keyMetrics))
        case .enter_UK:
            AnyShape(HilightShape_UK(keyMetrics: keyMetrics))
        case .arrow_Up:
            AnyShape(HilightShape_ArrowUp(keyMetrics: keyMetrics))
        case .arrow_Down:
            AnyShape(HilightShape_ArrowDown(keyMetrics: keyMetrics))
        default:
            AnyShape(RoundedRectangle(cornerRadius: keyMetrics.round_hilight))
        }
    }
        
    func keytopSize(_ keyMetrics: KeyMetrics) -> CGSize {
        //Paddingを含めないキートップのサイズ
        switch self {
        case .square:
            return keyMetrics.frame_keytop
        case .enter_JIS:
            return CGSize(
                width: (keyMetrics.baseSizeX * 1.5) - (keyMetrics.padding_keytop * 2),
                height: (keyMetrics.baseSizeY * 2) - (keyMetrics.padding_keytop * 2)
            )
        case .enter_UK:
            return CGSize(
                width: keyMetrics.baseSizeX - (keyMetrics.padding_keytop * 2),
                height: keyMetrics.baseSizeY * 2 - (keyMetrics.padding_keytop * 2)
            )
        case .enter_Tenkey:
            return CGSize(
                width: keyMetrics.baseSizeX - (keyMetrics.padding_keytop * 2),
                height: (keyMetrics.baseSizeY * 2) - (keyMetrics.padding_keytop * 2)
            )
        case .arrow_Up, .arrow_Down:
            return CGSize(
                width: keyMetrics.baseSizeX - (keyMetrics.padding_keytop * 2),
                height: (keyMetrics.baseSizeY / 2)  - (keyMetrics.padding_keytop + keyMetrics.strokeWidth_hilight)
            )
            
        case .arrow_LR:
            return CGSize(width: keyMetrics.baseSizeX - (keyMetrics.padding_keytop * 2), height: (keyMetrics.baseSizeY / 2) - (keyMetrics.padding_keytop * 2))
        }
    }
    func hilightFrameSize(_ keyMetrics: KeyMetrics) -> CGSize {
        switch self {
        case .square:
            return keyMetrics.frame_hilight
        case .enter_JIS:
            return CGSize(
                width: (keyMetrics.baseSizeX * 1.5) - (keyMetrics.padding_hilight * 2),
                height: (keyMetrics.baseSizeY * 2) - (keyMetrics.padding_hilight * 2)
            )
        case .enter_UK, .enter_Tenkey:
            return CGSize(
                width: keyMetrics.baseSizeX - (keyMetrics.padding_hilight * 2),
                height: (keyMetrics.baseSizeY * 2) - (keyMetrics.padding_hilight * 2)
            )
        case .arrow_Up, .arrow_Down:
            return CGSize(
                width: keyMetrics.baseSizeX  - (keyMetrics.padding_hilight * 2),
                height: (keyMetrics.baseSizeY / 2) - (keyMetrics.padding_hilight)
            )
        
        case .arrow_LR:
            return CGSize(width: keyMetrics.baseSizeX - (keyMetrics.padding_hilight * 2), height: (keyMetrics.baseSizeY / 2) - (keyMetrics.padding_hilight * 2))
        }
    }
    
    func frameSize(_ keyMetrics: KeyMetrics) -> CGSize {
        switch self {
        case .square:
            return CGSize(width: keyMetrics.frameWidth, height: keyMetrics.frameHeight)
        case .enter_JIS:
            return CGSize(width: keyMetrics.baseSizeX * 1.5, height: keyMetrics.baseSizeY * 2)
        case .enter_UK, .enter_Tenkey:
            return CGSize(width: keyMetrics.baseSizeX, height: keyMetrics.baseSizeY * 2)
        case .arrow_Up, .arrow_Down, .arrow_LR:
            return CGSize(width: keyMetrics.baseSizeX, height: keyMetrics.baseSizeY / 2)
        }
        
    }
}
