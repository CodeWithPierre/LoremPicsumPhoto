//
//  LoremPicsumPhotoDetailView.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 12/1/25.
//

import SwiftUI

/// Photo detail view.
struct LoremPicsumPhotoDetailView: View {
    let photo: LoremPicsumPhoto
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                AsyncImage(url: URL(string: photo.downloadURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .accessibilityLabel("Full photo by \(photo.author)")
                .accessibilityHint("This is the selected photo")
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    (
                        Text("Author: ").bold()
                        + Text(photo.author)
                    )
                    .font(.headline)
                    .accessibilityLabel("Author: \(photo.author)")
                    
                    (
                        Text("ID: ").bold()
                        + Text(photo.id)
                    )
                    .accessibilityLabel("Photo ID: \(photo.id)")
                    
                    (
                        Text("Size: ").bold()
                        + Text("\(photo.width.formatted(.number.grouping(.never)))x\(photo.height.formatted(.number.grouping(.never)))")
                    )
                    .accessibilityLabel("Resolution: \(photo.width)x\(photo.height)")
                    
                    (
                        Text("URL: ").bold()
                        + Text(photo.url)
                            .foregroundColor(.blue)
                    )
                    .textSelection(.enabled)
                    .accessibilityLabel("URL: \(photo.url)")
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.1)
                    
                }
            }
            .padding()
        }
        .navigationTitle("Photo Detail")
        .accessibilityElement(children: .contain)
    }
}
