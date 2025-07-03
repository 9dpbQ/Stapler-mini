//
//  TapHoldOptionsView.swift
//  Stapler-mini ViewExamples5
//
//  Created by qdpb on 2025/02/09.
//
import SwiftUI

struct TapHoldOptionsView: View {
    @Binding var toDetail: ToDetail
    
    
    var body: some View {
        if toDetail.isTapHoldEnabled {
            Picker("Tap Hold Type", selection: $toDetail.tapHoldType) {
                ForEach(TapHoldType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized).tag(type)
                        .help(type.helpText())
                }
            }
            .labelsHidden()
            .pickerStyle(.segmented)
            
            Toggle("lazy", isOn: $toDetail.is_lazy)
                .toggleStyle(.switch)
                .help("When lazy is enabled, the modifier key event will only be sent when pressed in combination with another key, not when pressed alone.")
            
            switch toDetail.tapHoldType {
            case .chord:
                Toggle("Threshold", isOn: $toDetail.is_alone_timeout_enabled)
                    .toggleStyle(.switch)
                if toDetail.is_alone_timeout_enabled {
                    Slider(
                        value: $toDetail.to_if_alone_timeout_milliseconds,
                        in: 500...1500, step: 100
                    ) {
                        Text("\(Int(toDetail.to_if_alone_timeout_milliseconds)) ms")
                    }
                }
            case .duration:
                Toggle("Threshold", isOn: $toDetail.is_held_down_threshold_enabled)
                    .toggleStyle(.switch)
                if toDetail.is_held_down_threshold_enabled {
                    Slider(
                        value: $toDetail.to_if_held_down_threshold_milliseconds,
                        in: 500...1500, step: 100
                    ) {
                        Text("\(Int(toDetail.to_if_held_down_threshold_milliseconds)) ms")
                    }
                }
                
            }
        } else {
            Text("Tap Hold is not Enabled")
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}
