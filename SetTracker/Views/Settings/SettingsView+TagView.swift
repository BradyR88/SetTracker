//
//  SettingsView+TagView.swift
//  SetTracker
//
//  Created by Brady Robshaw on 9/5/24.
//

import SwiftUI

extension SettingsView {
    struct TagView: View {
        var title: any StringProtocol
        var tags: [String]
        var textFieldTitle: LocalizedStringKey
        @Binding var newTag: String
        var onDelete: (String) -> Void
        var onAdd: () -> Void
        
        var body: some View {
            Section(title) {
                self.tagCloud
                self.addTagButton
            }
        }
        
        private var tagCloud: some View {
            TagCloudView(tags: tags) { tag in
                Button {
                    onDelete(tag)
                } label: {
                    HStack {
                        Text(tag)
                            .lineLimit(1)
                        Image(systemName: "x.circle")
                    }
                }
                .font(.footnote)
                .foregroundStyle(Color.primary)
                .buttonStyle(.bordered)
            }
        }
        
        private var addTagButton: some View {
            HStack {
                TextField(textFieldTitle, text: $newTag)
                    .textInputAutocapitalization(.words)
                
                Button {
                    onAdd()
                } label: {
                    Text("Add Setter")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    SettingsView.TagView(
        title: "Tag View",
        tags: ["tag 1", "Tag 2"],
        textFieldTitle: "New Tag",
        newTag: .constant("")) { tag in
            //
        } onAdd: {
            //
        }
}
