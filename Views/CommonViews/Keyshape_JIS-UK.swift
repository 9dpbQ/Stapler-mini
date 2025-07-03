//
//  Keyshape_JIS-UK.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2025/01/02.
//

import SwiftUI
struct KeytopShape_JIS: Shape {//キートップのフレームサイズでシェイプを作りたい
    let keyMetrics: KeyMetrics
    
    private var sumOfPadRou: CGFloat { keyMetrics.padding_keytop + keyMetrics.round_keytop }
    private var diffOfPadRou: CGFloat { keyMetrics.padding_keytop - keyMetrics.round_keytop }
    
    private var diffOfPadSmallRou: CGFloat { keyMetrics.padding_keytop - keyMetrics.enterSmallRound_keytop }

    func path(in rect: CGRect) -> Path {
        Path { path in
            
            //左上の角の丸みからスタート
            path.addArc(
                center: CGPoint(x: keyMetrics.round_keytop, y: keyMetrics.round_keytop),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            //右上の丸み
            path.addArc(
                center: CGPoint(x: rect.width - keyMetrics.round_keytop, y: keyMetrics.round_keytop),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            //右下の丸み
            path.addArc(
                center: CGPoint(x: rect.width - keyMetrics.round_keytop, y: rect.height - keyMetrics.round_keytop),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            //左下の丸み
            path.addArc(
                center: CGPoint(
                    x: (rect.width + (keyMetrics.padding_keytop * 2)) / 6 + keyMetrics.round_keytop,//Padding分すでにズレているのでroundのみで良い
                    y: rect.height - keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            //左中央の丸み1(丸みは他より小さくする)
            path.addArc(
                center:CGPoint(
                    x: (rect.width + (2 * keyMetrics.padding_keytop)) / 6 - keyMetrics.enterSmallRound_keytop,
                    y: (rect.height / 2) - diffOfPadSmallRou//キートップの中央からPaddingとRoundの差を引いてあげる
                ),
                radius: keyMetrics.enterSmallRound_keytop,
                startAngle: .degrees(0),
                endAngle: .degrees(-90),
                clockwise: true
            )
            
            //左中央の丸み2
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_keytop,
                    y: (rect.height / 2) - sumOfPadRou
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
        }
    }
}


struct HilightShape_JIS: Shape {
    let keyMetrics: KeyMetrics
    
    private var sumOfPadRou: CGFloat { keyMetrics.padding_keytop + keyMetrics.round_keytop }
    private var diffOfPadRou: CGFloat { keyMetrics.padding_keytop - keyMetrics.round_keytop }
    
    private var diffOfPadSmallRou: CGFloat { keyMetrics.padding_hilight - keyMetrics.enterSmallRound_hilight }

    func path(in rect: CGRect) -> Path {
        Path { path in
            
            //左上の角の丸みからスタート
            path.addArc(
                center: CGPoint(x: keyMetrics.round_hilight, y: keyMetrics.round_hilight),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            //右上の丸み
            path.addArc(
                center: CGPoint(x: rect.width - keyMetrics.round_hilight, y: keyMetrics.round_hilight),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            //右下の丸み
            path.addArc(
                center: CGPoint(x: rect.width - keyMetrics.round_hilight, y: rect.height - keyMetrics.round_hilight),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            //左下の丸み
            path.addArc(
                center: CGPoint(
                    x: (rect.width + (keyMetrics.padding_hilight * 2)) / 6 + keyMetrics.round_hilight,
                    y: rect.height - keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            //左中央の丸み1(丸みは他より小さくする)
            path.addArc(
                center:CGPoint(
                    x: (rect.width + (keyMetrics.padding_hilight * 2)) / 6 - keyMetrics.enterSmallRound_hilight,
                    y: (rect.height / 2) - diffOfPadSmallRou
                ),
                radius: keyMetrics.enterSmallRound_hilight,
                startAngle: .degrees(0),
                endAngle: .degrees(-90),
                clockwise: true
            )
            
            //左中央の丸み2
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_hilight,
                    y: (rect.height / 2) - sumOfPadRou
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
        }
    }
}
struct KeytopShape_UK: Shape {
    let keyMetrics: KeyMetrics
    
    private var sumOfPadRou: CGFloat { keyMetrics.padding_keytop + keyMetrics.round_keytop }
    private var diffOfPadRou: CGFloat { keyMetrics.padding_keytop - keyMetrics.round_keytop }
    
    private var diffOfPadSmallRou: CGFloat { keyMetrics.padding_keytop - keyMetrics.enterSmallRound_keytop}

    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            //左上の角の丸みからスタート
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_keytop,
                    y: keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            //右上の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_keytop,
                    y: keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            //右下の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_keytop,
                    y: rect.height - keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            //左下の丸み
            path.addArc(
                center: CGPoint(
                    x: ((rect.width + (keyMetrics.padding_keytop * 2)) / 4) + keyMetrics.round_keytop,
                    y: rect.height - keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            //左中央の丸み1
            path.addArc(
                center: CGPoint(
                    x: ((rect.width + (keyMetrics.padding_keytop * 2)) / 4) - keyMetrics.enterSmallRound_keytop,
                    y: (rect.height / 2) - diffOfPadSmallRou
                ),
                radius: keyMetrics.enterSmallRound_keytop,
                startAngle: .degrees(0),
                endAngle: .degrees(-90),
                clockwise: true
            )
            
            //左中央の丸み2
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_keytop,
                    y: (rect.height / 2) - sumOfPadRou
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
        }
    }
}

struct HilightShape_UK: Shape {
    let keyMetrics: KeyMetrics
    
    private var sumOfPadRou: CGFloat { keyMetrics.padding_keytop + keyMetrics.round_keytop }
    private var diffOfPadRou: CGFloat { keyMetrics.padding_keytop - keyMetrics.round_keytop }
    
    private var diffOfPadSmallRou: CGFloat { keyMetrics.padding_hilight - keyMetrics.enterSmallRound_hilight}

    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            //左上の角の丸みからスタート
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_hilight,
                    y: keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            //右上の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_hilight,
                    y: keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            //右下の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_hilight,
                    y: rect.height - keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            //左下の丸み
            path.addArc(
                center: CGPoint(
                    x: ((rect.width + (keyMetrics.padding_hilight * 2)) / 4) + keyMetrics.round_hilight,
                    y: rect.height - keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            //左中央の丸み1
            path.addArc(
                center: CGPoint(
                    x: ((rect.width + (keyMetrics.padding_hilight * 2)) / 4) - keyMetrics.enterSmallRound_hilight,
                    y: rect.height / 2 - diffOfPadSmallRou
                ),
                radius: keyMetrics.enterSmallRound_hilight,
                startAngle: .degrees(0),
                endAngle: .degrees(-90),
                clockwise: true
            )
            
            //左中央の丸み2
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_hilight,
                    y: rect.height / 2 - sumOfPadRou
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
        }
    }
}


struct KeytopShape_ArrowUp: Shape {
    let keyMetrics: KeyMetrics
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            //左上の角の丸みからスタート
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_keytop,
                    y: keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            
            //右上の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_keytop,
                    y: keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            //右下
            path.addLine(to: CGPoint(
                x: rect.width,
                y: rect.height
            ))
            
            //左下
            path.addLine(to: CGPoint(
                x: 0,
                y: rect.height
            ))
        }
    }
}

struct HilightShape_ArrowUp: Shape {
    let keyMetrics: KeyMetrics
    
    private var sumOfPadRou: CGFloat { keyMetrics.padding_keytop + keyMetrics.round_keytop }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            //左上の角の丸みからスタート
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_hilight,
                    y: keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            
            //右上の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_hilight,
                    y: keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(270),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            //右下
            path.addLine(to: CGPoint(
                x: rect.width,
                y: rect.height
            ))
            
            //左下
            path.addLine(to: CGPoint(
                x: 0,
                y: rect.height
            ))
            
        }
    }
}

struct KeytopShape_ArrowDown: Shape {
    let keyMetrics: KeyMetrics
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            //左上
            path.move(to: CGPoint(
                x: 0,
                y: 0
            ))
            
            //右上
            path.addLine(to: CGPoint(
                x: rect.width,
                y: 0
            ))
           
            
            //右下の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_keytop,
                    y: rect.height - keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            //左下
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_keytop,
                    y: rect.height - keyMetrics.round_keytop
                ),
                radius: keyMetrics.round_keytop,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
        }
    }
}
struct HilightShape_ArrowDown: Shape {
    let keyMetrics: KeyMetrics
        
    func path(in rect: CGRect) -> Path {
        Path { path in
            //左上
            path.move(to: CGPoint(x: 0, y: 0))
            
            //右上
            path.addLine(to: CGPoint(
                x: rect.width,
                y: 0
            ))
           
            
            //右下の丸み
            path.addArc(
                center: CGPoint(
                    x: rect.width - keyMetrics.round_hilight,
                    y: rect.height - keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            //左下
            path.addArc(
                center: CGPoint(
                    x: keyMetrics.round_hilight,
                    y: rect.height - keyMetrics.round_hilight
                ),
                radius: keyMetrics.round_hilight,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
        }
    }
}
