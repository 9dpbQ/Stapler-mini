//
//  KeyboardMonitor.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/21.
//

import SwiftUI

enum TapOrHold {
    case tap
    case hold
}
enum NextKeyboardKey {
    case toDetail
    case fromDetail
}
enum NextType {
    case add
    case select
}

class KeyboardMonitor: ObservableObject {
    @Published var lastModifierFlags: NSEvent.ModifierFlags = []
    
    private var monitorKeyDown: Any?
    private var monitorKeyUp: Any?
    private var monitorFlagsChanged: Any?
    private var monitorMouseClick: Any?
    
    private var activeModifiers: NSEvent.ModifierFlags = []  // 現在押されている修飾キー
    
    private var timeoutTimer: Timer?
    private let timeoutInterval: TimeInterval = 15.0 // 15秒でタイムアウト
    
    private func startTimeoutTimer(action: @escaping () -> Void) {
        // 既存のタイマーをキャンセル
        timeoutTimer?.invalidate()
        
        // 新しいタイマーを開始
        timeoutTimer = Timer.scheduledTimer(withTimeInterval: timeoutInterval, repeats: false) { _ in
            action()
        }
    }

    
    // MARK: - Remap
    ///次のキーへ移行して入力監視を再発火する関数
    func nextKeyboardKey(
        currentSelectedKeyboardKey_id: UUID?,
        configuration: Binding<Configuration>,
        type: NextKeyboardKey = .toDetail
    ) {
        // 次のキーへ移行
        if let nextKey: KeyboardKey = configuration.wrappedValue.keymap.getNextKeyboardKey(by: currentSelectedKeyboardKey_id) {
            configuration.wrappedValue.selections.keyboardKey = nextKey
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)  {
                switch type {
                case .toDetail:
                    self.startMonitoring_ToDetail_nextKeyboardKey(
//                        keyboardKey: nextKey,
                        configuration: configuration
                    )
                case .fromDetail:
                    self.startMonitoring_FromDetail(
//                        keyboardKey: configuration.selections.keyboardKey,
                        configuration: configuration
                    )
                    
                }
            }
            
        }
    }
    
    private func playCustomSound(fileName: String) {
        if let soundURL = Bundle.main.url(forResource: fileName, withExtension: "wav") { // "customSound.mp3"ファイルを指定
            let sound = NSSound(contentsOf: soundURL, byReference: false) // ファイルパスからサウンドをロード
            sound?.play() // カスタムサウンドを再生
        } else {
            print("カスタムサウンドファイルが見つかりませんでした")
        }
    }
    ///Remap用入力監視
    func startMonitoring_ToDetail_nextKeyboardKey(
//        keyboardKey: Binding<KeyboardKey>,
        configuration: Binding<Configuration>
    ) {
        if configuration.wrappedValue.selections.keyboardKey != .initialKey {
            
            //MARK: TODO ここにスタートのサウンド再生
//            playCustomSound(fileName: "SE_startMonitoring")
            
            let keyboardKey = configuration.wrappedValue.selections.keyboardKey
            keyboardKey.indicator = true
            self.clear() // 変数をクリア
            
            startTimeoutTimer {
                print("startMonitoring_ToDetai_nextKeyboardKey: Time out")
                self.stopMonitoring()
                keyboardKey.indicator = false
            }
            
            let toDetail: Binding<ToDetail> = keyboardKey.getBindingToDetail(
                condition: configuration.wrappedValue.selections.condition,
                layer: configuration.wrappedValue.selections.layer
            )
            
            self.monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
                guard let self = self else { return event }
                
                // 通常のキー押下処理
                if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                    toDetail.wrappedValue.applyTap(input)
                    self.lastModifierFlags = event.modifierFlags
                    keyboardKey.indicator = false
                    self.stopMonitoring()
                }
                
                // 修飾キー + 他のキーが押された場合の処理
                if !event.modifierFlags.isEmpty {
                    toDetail.wrappedValue.withModifier_tap.applyWithModifier(self.inputModifiers_withModifier(flags: event.modifierFlags))
                    self.stopMonitoring()
                    keyboardKey.indicator = false
                }
                //MARK: TODO ここにサウンド再生
//                playCustomSound(fileName: "SE_injectKeyInput")
                
                self.nextKeyboardKey(currentSelectedKeyboardKey_id: configuration.wrappedValue.selections.keyboardKey.id, configuration: configuration)
                
                return nil
            }
            
            self.monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
                guard let self = self else { return event }
                
                let previousModifiers = self.activeModifiers
                self.activeModifiers = event.modifierFlags
                
                let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
                if !removedModifiers.isEmpty {
                    if let input = self.returnModifierOutputDisplay(flags: removedModifiers) {
                        
                        toDetail.wrappedValue.applyTap(input, withModifier: self.inputModifiers_withModifier(flags: event.modifierFlags))
                        
                        self.stopMonitoring()
                        keyboardKey.indicator = false
                        
                        self.nextKeyboardKey(currentSelectedKeyboardKey_id: configuration.wrappedValue.selections.keyboardKey.id, configuration: configuration)
                    }
                }
                
                return nil
            }
            
            self.monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
                guard let self = self else { return event }
                
//                playCustomSound(fileName: "SE_teminateMonitoring")

                print("Mouse clicked, stopping monitoring...")
                self.stopMonitoring()
                
                keyboardKey.indicator = false
                
                return nil
            }
        }
    }
    
    // MARK: - KeyboardBuild
    ///FromDetail
    func startMonitoring_FromDetail(
//        keyboardKey: Binding<KeyboardKey>,
        configuration: Binding<Configuration>,
        isGoingToRepeat: Bool = true//ここでサイドバーやポップオーバーはfalseにすると連続した入力監視にならない
    ) {
        if configuration.wrappedValue.selections.keyboardKey != .initialKey {
            let keyboardKey = configuration.wrappedValue.selections.keyboardKey
            let fromDetail = keyboardKey.fromDetail
            keyboardKey.indicator = true
            clear() // 変数をクリア
            
            startTimeoutTimer {
                self.stopMonitoring()
                keyboardKey.indicator = false
            }
            
            monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
                guard let self = self else { return event }
                
                // 通常のキーを単体で押下処理
                if let input = KeyEventList.getFromKeycode(from: event.keyCode) {
                    
                    fromDetail.output = input
                    fromDetail.display = input.defaultDisplayString(.ANSI).display
                    fromDetail.isSFSymbol = input.defaultDisplayString(.ANSI).isSFSymbol
                    
                    self.lastModifierFlags = event.modifierFlags
                    keyboardKey.indicator = false
                    stopMonitoring()
                }
                if isGoingToRepeat {
                    self.nextKeyboardKey(currentSelectedKeyboardKey_id: keyboardKey.id, configuration: configuration, type: .fromDetail)
                }
                // イベントを macOS に通知しない
                return nil
            }
            // 就職キーが減った場合の処理
            monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
                guard let self = self else { return event }
                
                let previousModifiers = self.activeModifiers
                self.activeModifiers = event.modifierFlags
                
                let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
                if !removedModifiers.isEmpty {
                    if let modifierKey = returnFromKeycodeModifierKey(flags: removedModifiers) {
                        
                        
                        fromDetail.output = modifierKey
                        fromDetail.display = modifierKey.defaultDisplayString(.ANSI).display
                        fromDetail.isSFSymbol = modifierKey.defaultDisplayString(.ANSI).isSFSymbol
                        
                        self.stopMonitoring()
                        keyboardKey.indicator = false
                        
                        if isGoingToRepeat {
                            self.nextKeyboardKey(currentSelectedKeyboardKey_id: keyboardKey.id, configuration: configuration, type: .fromDetail)
                        }
                    }
                }
                
                return nil
            }
            // マウスクリックイベントを監視
            monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
                guard let self = self else { return event }
                print("Mouse clicked, stopping monitoring...")
                self.stopMonitoring()
                keyboardKey.indicator = false
                return nil
            }
        }
    }
    
    // MARK: - Combo
    func nextCombo(
        configuration: Binding<Configuration>,
        nextIndicator: Binding<Bool>,
        nextType: NextType = .select
    ) {
        if configuration.wrappedValue.isComboSelected {
            let combo = configuration.wrappedValue.selectedCombo
            let currentComboCollection = configuration.wrappedValue.comboCollection.getComboArray(
                condition: configuration.wrappedValue.selections.condition,
                layer: configuration.wrappedValue.selections.layer
            )
            let currentComboArray = currentComboCollection.array.sorted(
                by: { $0.simultaneouses.count > $1.simultaneouses.count }
            )
            
            switch nextType {
            case .add:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)  {
                    self.startMonitoring_Add_Combo(
                        configuration: configuration,
                        nextIndicator: nextIndicator
                    )
                }
            case .select:
                ///ここで次関数の処理
                if let currentIndex = currentComboArray.firstIndex(of: combo.wrappedValue) {
                    if currentIndex + 1 >= currentComboCollection.array.count {
                        //最後のやつの場合、別関数を発火、新しくComboを追加する関数ね
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.startMonitoring_Add_Combo(
                                configuration: configuration,
                                nextIndicator: nextIndicator
                            )
                        }
                    } else {
                        //次のcomboを選択状態に移す
                        configuration.wrappedValue.selections.combo = currentComboArray[currentIndex + 1]
                        //次のコンボを引数に自関数を再発火
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.startMonitoring_combo_Next(
                                //                            combo: configuration.selections.combo,
                                configuration: configuration,
                                nextIndicator: nextIndicator
                            )
                        }
                    }
                }
            }
        }
    }
    
    ///入力を監視、注入したあと、次のComboを引数に自関数を発火
    ///配列の最後の場合、新しく入力を監視して、その入力でComboを作成する関数を発火する
    func startMonitoring_combo_Next(
//        combo: Binding<Combo>,
        configuration: Binding<Configuration>,
        nextIndicator: Binding<Bool>
    ) {
        if configuration.wrappedValue.isComboSelected {
            let combo = configuration.wrappedValue.selectedCombo
            let toDetail = combo.toDetail
            let indicator = combo.indicator
            
            indicator.wrappedValue = true
            clear() // 変数をクリア
            
            startTimeoutTimer {
                self.stopMonitoring()
                indicator.wrappedValue = false
            }
            
            let currentComboCollection = configuration.wrappedValue.comboCollection.getComboArray(
                condition: configuration.wrappedValue.selections.condition,
                layer: configuration.wrappedValue.selections.layer
            )
            //        let currentComboArray = currentComboCollection.array.sorted(
            //            by: { $0.simultaneouses.count > $1.simultaneouses.count }
            //        )
            
            monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
                guard let self = self else { return event }
                
                // 通常のキーを単体で押下処理
                if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                    
                    toDetail.wrappedValue.isMacro_tap = false
                    toDetail.wrappedValue.isCustomized_tap = true
                    toDetail.wrappedValue.outputAndDisplay_tap.applyOutputDisplay(input)
                    toDetail.wrappedValue.withModifier_tap.applyWithModifier(WithModifier())
                    
                    self.lastModifierFlags = event.modifierFlags
                    indicator.wrappedValue = false
                    stopMonitoring()
                }
                // 修飾キー + 他のキーが押された場合の処理
                if !self.activeModifiers.isEmpty {
                    toDetail.wrappedValue.withModifier_tap.applyWithModifier(self.inputModifiers_withModifier(flags: self.activeModifiers))
                    self.stopMonitoring()
                    indicator.wrappedValue = false
                }
                self.nextCombo(configuration: configuration, nextIndicator: nextIndicator)
                
                // イベントを macOS に通知しない
                return nil
            }
            // 就職キーが減った場合の処理(単打かホールドかに修飾キーを入れる)
            monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
                guard let self = self else { return event }
                
                let previousModifiers = self.activeModifiers
                self.activeModifiers = event.modifierFlags
                
                let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
                if !removedModifiers.isEmpty {
                    
                    if let oad = returnModifierOutputDisplay(flags: removedModifiers) {
                        toDetail.wrappedValue.isCustomized_tap = true
                        toDetail.wrappedValue.outputAndDisplay_tap = oad
                        self.stopMonitoring()
                        indicator.wrappedValue = false
                    }
                    
                    if !self.activeModifiers.isEmpty {
                        toDetail.wrappedValue.withModifier_tap.applyWithModifier(self.inputModifiers_withModifier(flags: self.activeModifiers))
                        self.stopMonitoring()
                        indicator.wrappedValue = false
                    }
                    
                    self.nextCombo(configuration: configuration, nextIndicator: nextIndicator)
                    
                }
                return nil
            }
            // マウスクリックイベントを監視
            monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
                guard let self = self else { return event }
                print("Mouse clicked, stopping monitoring...")
                self.stopMonitoring()
                indicator.wrappedValue = false
                return nil
            }
        }
    }
    ///入力監視してその入力のcomboを追加する関数
    func startMonitoring_Add_Combo(
        configuration: Binding<Configuration>,
        nextIndicator: Binding<Bool>
    ) {
        nextIndicator.wrappedValue = true
        clear() // 変数をクリア
        
        startTimeoutTimer {
            print("Motitor time out")
            self.stopMonitoring()
            nextIndicator.wrappedValue = false
        }
        
        let currentComboCollection = configuration.wrappedValue.comboCollection.getComboArray(
            condition: configuration.wrappedValue.selections.condition,
            layer: configuration.wrappedValue.selections.layer
        )
        let currentComboArray = currentComboCollection.array.sorted(
            by: { $0.simultaneouses.count > $1.simultaneouses.count }
        )
        
        monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            
            // 通常のキーを単体で押下処理
            if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                
                let newCombo = Combo(toDetail: ToDetail())
                newCombo.toDetail.isCustomized_tap = true
                newCombo.toDetail.outputAndDisplay_tap = input
                currentComboCollection.array.append(newCombo)
                configuration.wrappedValue.selections.combo = newCombo
                
                self.lastModifierFlags = event.modifierFlags
                stopMonitoring()
                nextIndicator.wrappedValue = false
            }
            
            // 修飾キー + 他のキーが押された場合の処理
            if !self.activeModifiers.isEmpty {
                currentComboArray.last?.toDetail.withModifier_tap.applyWithModifier(self.inputModifiers_withModifier(flags: self.activeModifiers))
                
                self.stopMonitoring()
                
                nextIndicator.wrappedValue = false
            }
            
            self.nextCombo(configuration: configuration, nextIndicator: nextIndicator, nextType: .add)
            
            // イベントを macOS に通知しない
            return nil
        }
        // 就職キーが減った場合の処理(単打かホールドかに修飾キーを入れる)
        monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self = self else { return event }
            
            let previousModifiers = self.activeModifiers
            self.activeModifiers = event.modifierFlags
            
            let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
            if !removedModifiers.isEmpty {
                
                if let oad = returnModifierOutputDisplay(flags: removedModifiers) {
                    
                    let newCombo = Combo(toDetail: ToDetail())
                    newCombo.toDetail.isCustomized_tap = true
                    newCombo.toDetail.outputAndDisplay_tap.applyOutputDisplay(oad)
                    currentComboCollection.array.append(newCombo)
                    
                    configuration.wrappedValue.selections.combo = newCombo
                    
                    self.stopMonitoring()
                    nextIndicator.wrappedValue = false
                    self.nextCombo(configuration: configuration, nextIndicator: nextIndicator, nextType: .add)

                }
            }
            return nil
        }
        // マウスクリックイベントを監視
        monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return event }
            
            print("Mouse clicked, stopping monitoring...")
            self.stopMonitoring()
            
            nextIndicator.wrappedValue = false
            return nil
            
        }
        
    }
    
    // MARK: - Macro
    
    func nextToDetail_macro(
//        toDetail: Binding<ToDetail_macro>,
        macro: Binding<Macro>,
        configuration: Binding<Configuration>,
        nextIndicator: Binding<Bool>,
        nextType: NextType = .select
    ) {
        if configuration.wrappedValue.isToDetail_macroSelected {
            let toDetail = configuration.wrappedValue.selectedToDetail_macro
            switch nextType {
            case .add:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)  {
                    self.startMonitoring_Add_ToDetail_Macro(
                        macro: macro,
                        configuration: configuration,
                        nextIndicator: nextIndicator
                    )
                }
            case .select:
                if let currentIndex = macro.wrappedValue.toDetailCollection.collection.firstIndex(of: toDetail.wrappedValue) {
                    if macro.wrappedValue.toDetailCollection.collection[currentIndex] === macro.wrappedValue.toDetailCollection.collection.last {
                        //最後のToDetail_Macroの場合、別関数を発火
                        //新しくToDetail_ macroを追加する処理！
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)  {
                            self.startMonitoring_Add_ToDetail_Macro(
                                macro: macro,
                                configuration: configuration,
                                nextIndicator: nextIndicator
                            )
                        }
                    } else {
                        //次のToDetailがある場合, 次のToDetailを引数に自関数を再発火させる
                        configuration.wrappedValue.selections.toDetail_macro = macro.wrappedValue.toDetailCollection.collection[currentIndex + 1]
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6)  {
                            self.startMonitoring_ToDetail_Macro_Next(
                                toDetail: macro.toDetailCollection.collection[currentIndex + 1],
                                macro: macro,
                                configuration: configuration,
                                nextIndicator: nextIndicator
                            )
                        }
                    }
                }
            }
        }
    }
    ///入力を受け取ったら、配列から次のToDetail＿Macroを渡すようにして一気に入力監視をできる関数
    ///もし配列の最後なら、入力を監視して、その入力のToDetail＿ macroを追加する別関数を発火するようにする
    func startMonitoring_ToDetail_Macro_Next(
        toDetail: Binding<ToDetail_macro>,
        macro: Binding<Macro>,
        configuration: Binding<Configuration>,
        nextIndicator: Binding<Bool>
    ) {
        toDetail.indicator.wrappedValue = true
        clear() // 変数をクリア
        startTimeoutTimer {
            print("Monitor Time out...")
            self.stopMonitoring()
            toDetail.indicator.wrappedValue = false
        }
        
        monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            
            // 通常のキーを単体で押下処理
            if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                toDetail.wrappedValue.applyTap(input)

                self.lastModifierFlags = event.modifierFlags
                stopMonitoring()
                toDetail.indicator.wrappedValue = false
            }
            
            // 修飾キー + 他のキーが押された場合の処理
            if !self.activeModifiers.isEmpty {
                toDetail.wrappedValue.withModifier.applyWithModifier(self.inputModifiers_withModifier(flags: self.activeModifiers))
                self.stopMonitoring()
                toDetail.indicator.wrappedValue = false
            }
            self.nextToDetail_macro(
                macro: macro,
                configuration: configuration,
                nextIndicator: nextIndicator
            )
            // イベントを macOS に通知しない
            return nil
        }
        // 就職キーが減った場合の処理(単打に修飾キーを入れる)
        monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self = self else { return event }
            
            let previousModifiers = self.activeModifiers
            self.activeModifiers = event.modifierFlags
            
            let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
            if !removedModifiers.isEmpty {
                
                if let oad = returnModifierOutputDisplay(flags: removedModifiers) {
                    toDetail.wrappedValue.outputAndDisplay = oad
                    self.stopMonitoring()
                    toDetail.indicator.wrappedValue = false
                    self.nextToDetail_macro(macro: macro, configuration: configuration, nextIndicator: nextIndicator)
                }
            }
            return nil
        }
        // マウスクリックイベントを監視
        monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return event }
            print("Mouse clicked, stopping monitoring...")
            self.stopMonitoring()
            toDetail.indicator.wrappedValue = false
            return nil
            
        }
    }
    
    
    ///入力を監視してその入力のToDetail_ macroを追加する関数
    ///これも最後に自分自身を発火することで追加をスムーズに行うことができるようにする
    func startMonitoring_Add_ToDetail_Macro(
        macro: Binding<Macro>,
        configuration: Binding<Configuration>,
        //配列の最後だった場合、↓インジケータを関数内でトグルする。このインケーターは追加ボタンの上に表示する予定
        nextIndicator: Binding<Bool>
    ) {
        nextIndicator.wrappedValue = true
        clear() // 変数をクリア
        startTimeoutTimer {
            print("Monitor Time Out")
            self.stopMonitoring()
            nextIndicator.wrappedValue = false
        }
        
        monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            
            // 通常のキーを単体で押下処理
            if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                let newToDetail_macro = ToDetail_macro(output: input.output, display: input.display, isSFSymbol: input.isSFSymbol)
                macro.wrappedValue.toDetailCollection.collection.append(newToDetail_macro)
                configuration.wrappedValue.selections.toDetail_macro = newToDetail_macro
                self.lastModifierFlags = event.modifierFlags
                stopMonitoring()
                nextIndicator.wrappedValue = false
            }
            
            // 修飾キー + 他のキーが押された場合の処理
            if !self.activeModifiers.isEmpty {
                macro.wrappedValue.toDetailCollection.collection.last?.withModifier.applyWithModifier(self.inputModifiers_withModifier(flags: self.activeModifiers))
                self.stopMonitoring()
                
                nextIndicator.wrappedValue = false
            }
            
            self.nextToDetail_macro(
                macro: macro,
                configuration: configuration,
                nextIndicator: nextIndicator,
                nextType: .add
            )
            // イベントを macOS に通知しない
            return nil
        }
        // 就職キーが減った場合の処理(単打かホールドかに修飾キーを入れる)
        monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self = self else { return event }
            
            let previousModifiers = self.activeModifiers
            self.activeModifiers = event.modifierFlags
            
            let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
            if !removedModifiers.isEmpty {
                
                if let input = returnModifierOutputDisplay(flags: removedModifiers) {
                    let newToDetail_macro = ToDetail_macro(output: input.output, display: input.display, isSFSymbol: input.isSFSymbol)
                    macro.wrappedValue.toDetailCollection.collection.append(newToDetail_macro)
                    configuration.wrappedValue.selections.toDetail_macro = newToDetail_macro
                    self.stopMonitoring()
                    nextIndicator.wrappedValue = false
                    self.nextToDetail_macro(
                        macro: macro,
                        configuration: configuration,
                        nextIndicator: nextIndicator,
                        nextType: .add
                    )
                }
            }
            return nil
        }
        // マウスクリックイベントを監視
        monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return event }
            print("Mouse clicked, stopping monitoring...")
            self.stopMonitoring()
            nextIndicator.wrappedValue = false
            return nil
        }
    }
    
    //次に遷移しない関数群。サイドバーやポップオーバー用の関数
    func startMonitoring_ToDetail(
        _ toDetail: Binding<ToDetail>,
        type: TapOrHold,
        indicator: Binding<Bool>
    ) {
        indicator.wrappedValue = true
        clear() // 変数をクリア
        startTimeoutTimer {
            print("StartMonitoring_ToDetail: monitor time Out")
            self.stopMonitoring()
            indicator.wrappedValue = false
        }
        
        monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            
            // 通常のキーを単体で押下処理
            if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                switch type {
                case .tap:
                    toDetail.wrappedValue.applyTap(input)
                case .hold:
                    toDetail.wrappedValue.applyHold(input)
                }
                self.lastModifierFlags = event.modifierFlags
                indicator.wrappedValue = false
                stopMonitoring()
            }
            // 修飾キー + 他のキーが押された場合の処理
            if !self.activeModifiers.isEmpty {
                switch type {
                case .tap:
                    toDetail.wrappedValue.withModifier_tap.applyWithModifier(
                        self.inputModifiers_withModifier(flags: self.activeModifiers)
                    )
                case .hold:
                    toDetail.wrappedValue.withModifier_hold.applyWithModifier(
                        self.inputModifiers_withModifier(flags: self.activeModifiers)
                    )
                }
                self.stopMonitoring()
                indicator.wrappedValue = false
                
            }
            // イベントを macOS に通知しない
            return nil
        }
        // 就職キーが減った場合の処理(単打かホールドかに修飾キーを入れる)
        monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self = self else { return event }
            
            let previousModifiers = self.activeModifiers
            self.activeModifiers = event.modifierFlags
            
            let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
            if !removedModifiers.isEmpty {
                
                if let input = returnModifierOutputDisplay(flags: removedModifiers) {
                    switch type {
                    case .tap:
                        toDetail.wrappedValue.applyTap(input)
                    case .hold:
                        toDetail.wrappedValue.applyHold(input)
                    }
                    self.stopMonitoring()
                    
                    indicator.wrappedValue = false
                }
                
                if !self.activeModifiers.isEmpty {
                    switch type {
                    case .tap:
                        toDetail.wrappedValue.withModifier_tap.applyWithModifier(
                            self.inputModifiers_withModifier(flags: self.activeModifiers)
                        )
                    case .hold:
                        toDetail.wrappedValue.withModifier_hold.applyWithModifier(
                            self.inputModifiers_withModifier(flags: self.activeModifiers)
                        )
                    }
                    self.stopMonitoring()
                    
                    indicator.wrappedValue = false
                }
            }
            return nil
        }
        // マウスクリックイベントを監視
        monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return event }
            print("Mouse clicked, stopping monitoring...")
            self.stopMonitoring()
            indicator.wrappedValue = false
            return nil
        }
    }
    
    //次に遷移しない関数群。サイドバーやポップオーバー用の関数
    func startMonitoring_toDetail_multi(
        _ toDetail: Binding<ToDetail_multi>,
        type: TapOrHold,
        indicator: Binding<Bool>
    ) {
//        print("start monitoring key input... current indicator: \(indicator.wrappedValue)")
        indicator.wrappedValue = true
//        print("and then indicator: \(indicator.wrappedValue)")
        clear() // 変数をクリア
        startTimeoutTimer {
            print("startMonitoring_ToDetail_multi: Time out")
            self.stopMonitoring()
            indicator.wrappedValue = false
        }
        
        
        monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            
            // 通常のキーを単体で押下処理
            if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                switch type {
                case .tap:
                    toDetail.wrappedValue.applyTap(input)
                case .hold:
                    toDetail.wrappedValue.applyHold(input)
                }
                self.lastModifierFlags = event.modifierFlags
                indicator.wrappedValue = false
                stopMonitoring()
            }
            // 修飾キー + 他のキーが押された場合の処理
            if !self.activeModifiers.isEmpty {
                switch type {
                case .tap:
                    toDetail.wrappedValue.withModifier_tap.applyWithModifier(
                        self.inputModifiers_withModifier(flags: self.activeModifiers)
                    )
                case .hold:
                    toDetail.wrappedValue.withModifier_hold.applyWithModifier(
                        self.inputModifiers_withModifier(flags: self.activeModifiers)
                    )
                }
                
                self.stopMonitoring()
                
                indicator.wrappedValue = false
                
            }
            // イベントを macOS に通知しない
            return nil
        }
        // 就職キーが減った場合の処理(単打かホールドかに修飾キーを入れる)
        monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self = self else { return event }
            
            let previousModifiers = self.activeModifiers
            self.activeModifiers = event.modifierFlags
            
            let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
            if !removedModifiers.isEmpty {
                
                if let input = returnModifierOutputDisplay(flags: removedModifiers) {
                    switch type {
                    case .tap:
                        toDetail.wrappedValue.applyTap(input)
                    case .hold:
                        toDetail.wrappedValue.applyHold(input)
                    }
                    self.stopMonitoring()
                    
                    indicator.wrappedValue = false
                }
                
                if !self.activeModifiers.isEmpty {
                    switch type {
                    case .tap:
                        toDetail.wrappedValue.withModifier_tap.applyWithModifier(
                            self.inputModifiers_withModifier(flags: self.activeModifiers)
                        )
                    case .hold:
                        toDetail.wrappedValue.withModifier_hold.applyWithModifier(
                            self.inputModifiers_withModifier(flags: self.activeModifiers)
                        )
                    }
                    self.stopMonitoring()
                    
                    indicator.wrappedValue = false
                }
            }
            return nil
        }
        // マウスクリックイベントを監視
        monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return event }
            print("Mouse clicked, stopping monitoring...")
            self.stopMonitoring()
            indicator.wrappedValue = false
            return nil
        }
    }
    
    ///次に遷移しない入力監視関数
    func startMonitoring_ToDetailMacro(
        _ toDetail: Binding<ToDetail_macro>,
        indicator: Binding<Bool>
    ) {
        indicator.wrappedValue = true
        clear() // 変数をクリア
        startTimeoutTimer {
            print("StartMonitoring_toDetailMacro: Time out")
            self.stopMonitoring()
            indicator.wrappedValue = false
        }
        
        monitorKeyDown = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            guard let self = self else { return event }
            
            // 通常のキーを単体で押下処理
            if let input = KeyEventList.getOutputAndDisplay(from: event.keyCode) {
                toDetail.wrappedValue.applyTap(input)
                self.lastModifierFlags = event.modifierFlags
                stopMonitoring()
                indicator.wrappedValue = false
            }
            
            // 修飾キー + 他のキーが押された場合の処理
            if !self.activeModifiers.isEmpty {
                toDetail.wrappedValue.withModifier.applyWithModifier(self.inputModifiers_withModifier(flags: self.activeModifiers))
                self.stopMonitoring()
                indicator.wrappedValue = false
            }
            // イベントを macOS に通知しない
            return nil
        }
        // 就職キーが減った場合の処理(単打かホールドかに修飾キーを入れる)
        monitorFlagsChanged = NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { [weak self] event in
            guard let self = self else { return event }
            
            let previousModifiers = self.activeModifiers
            self.activeModifiers = event.modifierFlags
            
            let removedModifiers = previousModifiers.subtracting(self.activeModifiers)
            if !removedModifiers.isEmpty {
                
                if let input = returnModifierOutputDisplay(flags: removedModifiers) {
                    toDetail.wrappedValue.applyTap(input)
                    self.stopMonitoring()
                    indicator.wrappedValue = false
                }
            }
            return nil
        }
        // マウスクリックイベントを監視
        monitorMouseClick = NSEvent.addLocalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return event }
            print("Mouse clicked, stopping monitoring...")
            self.stopMonitoring()
            indicator.wrappedValue = false
            return nil
        }
    }
    
    // メモリリーク防止のためのdeinit
    deinit {
        stopMonitoring()
    }
}

extension KeyboardMonitor {
    
    
    ///汎用関数
    func clear() {
        self.lastModifierFlags = []
        self.activeModifiers = []  // 現在押されている修飾キー
    }
    
    
    func stopMonitoring() {
        
        timeoutTimer?.invalidate()
        timeoutTimer = nil

        if let monitorKeyDown = monitorKeyDown {
            NSEvent.removeMonitor(monitorKeyDown)
            self.monitorKeyDown = nil
        }
        if let monitorKeyUp = monitorKeyUp {
            NSEvent.removeMonitor(monitorKeyUp)
            self.monitorKeyUp = nil
        }
        if let monitorFlagsChanged = monitorFlagsChanged {
            NSEvent.removeMonitor(monitorFlagsChanged)
            self.monitorFlagsChanged = nil
        }
        if let monitorMouseClick = monitorMouseClick {
            NSEvent.removeMonitor(monitorMouseClick)
            self.monitorMouseClick = nil
        }
    }
    
    private func modifierKeyDescription(flags: NSEvent.ModifierFlags) -> String {
        var descriptions: [String] = []
        if flags.contains(.command) { descriptions.append("Command") }
        if flags.contains(.option) { descriptions.append("Option") }
        if flags.contains(.shift) { descriptions.append("Shift") }
        if flags.contains(.control) { descriptions.append("Control") }
        if flags.contains(.function) { descriptions.append("Fn") }
        return descriptions.joined(separator: ", ")
    }
    
    private func returnModifierOutputDisplay(flags: NSEvent.ModifierFlags) -> OutputAndDisplay? {
        if flags.contains(.command) {
            return OutputAndDisplay(output:.modifier_keys(.left_command), display: "command", isSFSymbol: true)
        }
        if flags.contains(.option) {
            return OutputAndDisplay(output:.modifier_keys(.left_option), display: "option", isSFSymbol: true)
        }
        if flags.contains(.shift) {
            return OutputAndDisplay(output:.modifier_keys(.left_shift), display: "shift", isSFSymbol: true)
        }
        if flags.contains(.control) {
            return OutputAndDisplay(output:.modifier_keys(.left_control), display: "control", isSFSymbol: true)
        }
        if flags.contains(.function) {
            return OutputAndDisplay(output:.modifier_keys(.keyboard_fn), display: "fn", isSFSymbol: false)
        }
        return nil
    }
    private func returnFromKeycodeModifierKey(flags: NSEvent.ModifierFlags) -> FromKeycode? {
        if flags.contains(.command) {
            return .modifier_keys(.left_command)
        }
        if flags.contains(.option) {
            return .modifier_keys(.left_option)
        }
        if flags.contains(.shift) {
            return .modifier_keys(.left_shift)
        }
        if flags.contains(.control) {
            return .modifier_keys(.left_control)
        }
        if flags.contains(.function) {
            return .modifier_keys(.keyboard_fn)
        }
        return nil
    }
    
    private func inputModifiers_withModifier(flags: NSEvent.ModifierFlags) -> WithModifier {
        let withModifier = WithModifier()
        if flags.contains(.command) {
            withModifier.isWithModifier = true
            withModifier.isWithCommand = true
        }
        if flags.contains(.option) {
            withModifier.isWithModifier = true
            withModifier.isWithOption = true
        }
        if flags.contains(.shift) {
            withModifier.isWithModifier = true
            withModifier.isWithShift = true
        }
        if flags.contains(.control) {
            withModifier.isWithModifier = true
            withModifier.isWithControl = true
        }
        if flags.contains(.function) {
            withModifier.isWithModifier = true
            withModifier.isWithFunction = true
        }
        return withModifier
    }
}
