//
//  DropDestinationFunction.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/11.
//
/// 各クラスのドロップの処理

import SwiftUI

extension FromDetail {
    func applyCustom(_ customizeKey_from: CustomizeKey_from) {
        self.output = customizeKey_from.output
        self.display = customizeKey_from.display
        self.isSFSymbol = customizeKey_from.isUsingSFSymbol
    }
    func applyCustom_fromDetail(_ fromDetail: FromDetail) {
        self.output = fromDetail.output
        self.display = fromDetail.display
        self.isSFSymbol = fromDetail.isSFSymbol
    }
}

extension KeyboardKey {
    func copyOtherToDetail(from other: ToDetail, condition: SpecificCondition, layer: Layer) {
        getToDetail(condition, layer: layer).copyOtherToDetail(from: other)
    }
    
    func applyCustom_from(from custom: CustomizeKey_from) {
        self.fromDetail.applyCustom(custom)
    }
    func applyCustom_from_ByFromDetail(_ fromDetail: FromDetail) {
        self.fromDetail.applyCustom_fromDetail(fromDetail)
    }
    func applyCustom_tap(from custom: CustomizeKey_to, condition: SpecificCondition, layer: Layer) {
        getToDetail(condition, layer: layer).applyCustom_tap(custom: custom)
    }
    func applyCustom_hold(from custom: CustomizeKey_to, condition: SpecificCondition, layer: Layer) {
        getToDetail(condition, layer: layer).applyCustom_hold(custom: custom)
    }
    
    func applyMacro_tap(from macro: Macro, condition: SpecificCondition, layer: Layer) {
        getToDetail(condition, layer: layer).applyMacro_tap(macro: macro)
    }
    func applyMacro_hold(from macro: Macro, condition: SpecificCondition, layer: Layer) {
        getToDetail(condition, layer: layer).applyMacro_hold(macro: macro)
    }
}

extension Combo {
    func applyCustom_tap(from custom: CustomizeKey_to) {
        self.toDetail.applyCustom_tap(custom: custom)
    }
    func applyCustom_hold(from custom: CustomizeKey_to) {
        self.toDetail.applyCustom_hold(custom: custom)
    }
    func applyMacro_tap(from macro: Macro) {
        self.toDetail.applyMacro_tap(macro: macro)
    }
    func applyMacro_hold(from macro: Macro) {
        self.toDetail.applyMacro_hold(macro: macro)
    }
}
extension ToDetail {
    func copyOtherToDetail(from other: ToDetail) {
        self.error = false
        // idは変更しない
        self.isTapHoldEnabled = other.isTapHoldEnabled
        self.tapHoldType = other.tapHoldType
        
        self.is_held_down_threshold_enabled = other.is_held_down_threshold_enabled
        self.to_if_held_down_threshold_milliseconds = other.to_if_held_down_threshold_milliseconds
        
        self.is_alone_timeout_enabled = other.is_alone_timeout_enabled
        self.to_if_alone_timeout_milliseconds = other.to_if_alone_timeout_milliseconds
        
        self.is_lazy = other.is_lazy
        self.is_repeat = other.is_repeat
        
        self.isCustomized_tap = other.isCustomized_tap
        self.outputAndDisplay_tap.applyOutputDisplay(other.outputAndDisplay_tap)
        self.withModifier_tap = other.withModifier_tap
        self.isMacro_tap = other.isMacro_tap
        self.macro_id_tap = other.macro_id_tap
        
        self.isCustomized_hold = other.isCustomized_hold
        self.outputAndDisplay_hold.applyOutputDisplay(other.outputAndDisplay_hold)
        self.withModifier_hold = other.withModifier_hold
        self.isMacro_hold = other.isMacro_hold
        self.macro_id_hold = other.macro_id_hold
        
        self.isUserCustomJSONEnabled = other.isUserCustomJSONEnabled
        self.userJSONEContent = other.userJSONEContent
        
        other.isTapHoldEnabled = false // test
    }
    func applyCustom_tap(custom: CustomizeKey_to) {
        self.error = false
        
        self.isCustomized_tap = true
        self.isMacro_tap = false
        self.outputAndDisplay_tap.output = custom.output
        self.outputAndDisplay_tap.display = custom.display
        self.outputAndDisplay_tap.isSFSymbol = custom.isUsingSFSymbol
        self.outputAndDisplay_tap.layerKey = custom.layerKeyNumber ?? .layer0
    }
    func applyCustom_hold(custom: CustomizeKey_to) {
        self.error = false
        
        self.isTapHoldEnabled = true
        self.isCustomized_hold = true
        self.isMacro_hold = false
        self.outputAndDisplay_hold.output = custom.output
        self.outputAndDisplay_hold.display = custom.display
        self.outputAndDisplay_hold.isSFSymbol = custom.isUsingSFSymbol
        self.outputAndDisplay_hold.layerKey = custom.layerKeyNumber ?? .layer0
    }
    func applyMacro_tap(macro: Macro) {
        self.error = false
        
        self.isCustomized_tap = true
        self.isMacro_tap = true
        
        self.macro_id_tap = macro.dictionary_key ?? macro.id.uuidString
    }
    func applyMacro_hold(macro: Macro) {
        self.error = false
        
        self.isCustomized_hold = true
        self.isMacro_hold = true
        self.macro_id_hold = macro.dictionary_key ?? macro.id.uuidString
    }
}

extension ToDetail_macro {
    func applyCustom(from custom: CustomizeKey_to) {
        self.error = false
        
        self.outputAndDisplay.output = custom.output
        self.outputAndDisplay.display = custom.display
        self.outputAndDisplay.isSFSymbol = custom.isUsingSFSymbol
    }
}

extension ToDetail_multi {
    func applyCustom_tap(from custom: CustomizeKey_to) {
        self.isCustomized_tap = true
        self.isMacro_tap = false
        self.outputAndDisplay_tap.output = custom.output
        self.outputAndDisplay_tap.display = custom.display
        self.outputAndDisplay_tap.isSFSymbol = custom.isUsingSFSymbol
        self.outputAndDisplay_tap.layerKey = custom.layerKeyNumber ?? .layer0
    }
    func applyCustom_hold(from custom: CustomizeKey_to) {
        self.isCustomized_hold = true
        self.isMacro_hold = false
        self.outputAndDisplay_hold.output = custom.output
        self.outputAndDisplay_hold.display = custom.display
        self.outputAndDisplay_hold.isSFSymbol = custom.isUsingSFSymbol
        self.outputAndDisplay_hold.layerKey = custom.layerKeyNumber ?? .layer0
    }
    func applyMacro_tap(from macro: Macro) {
        self.isCustomized_tap = true
        self.isMacro_tap = true
        self.macro_id_tap = macro.dictionary_key ?? macro.id.uuidString
    }
    func applyMacro_hold(from macro: Macro) {
        self.isCustomized_hold = true
        self.isMacro_hold = true
        self.macro_id_hold = macro.dictionary_key ?? macro.id.uuidString
    }
}
