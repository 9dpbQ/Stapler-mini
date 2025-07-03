import SwiftData
//
//  SelectedDetailView.swift
//  Stapler-mini ViewExamples3
//
//  Created by qdpb on 2024/12/09.
//
import SwiftUI

struct SidebarView: View {

    @EnvironmentObject private var viewModel: ViewModel
    private var tab: SelectedTab {
        viewModel.configuration.selections.tab
    }
    var body: some View {
        Group {
            if viewModel.configuration != .initialConfig {
                if tab == .macro {
                    SidebarView_Macro()
                }
                if tab == .deviceEdit {
                    SidebarView_Build()
                }
                if tab == .remap {
                    SidebarView_Remap()
                }
                if tab == .combo {
                    SidebarView_Combo()
                }
            } else {
                Text("Select Configuration from left sidebar")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    

}

struct InitialComboView: View {
    var body: some View {
        VStack {
            Text("Select any Combo or Click Add Button.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}
struct InitialMacroView: View {
    var body: some View {
        VStack {
            Text("Select any Macro or Click Add Button.")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}
