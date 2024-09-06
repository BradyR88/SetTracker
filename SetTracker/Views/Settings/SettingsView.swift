//
//  SettingsView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 5/16/24.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        Form {
            self.setterSection
            self.zoneSection
        }
    }
    
    //MARK: Setter Section
    @ViewBuilder
    private var setterSection: some View {
        SettingsView.TagView(
            title: "Setters",
            tags: viewModel.setters,
            textFieldTitle: "New Setter",
            newTag: $viewModel.newSetter,
            onDelete: { viewModel.deleteSetter($0) },
            onAdd: { viewModel.addSetter() }
        )
    }
    
    //MARK: Zones
    private var zoneSection: some View {
        SettingsView.TagView(
            title: "Zones",
            tags: viewModel.zones,
            textFieldTitle: "New Zone",
            newTag: $viewModel.newZone,
            onDelete: { viewModel.deleteZone($0) },
            onAdd: { viewModel.addZone() }
        )
    }
}

#Preview {
    SettingsView()
}
