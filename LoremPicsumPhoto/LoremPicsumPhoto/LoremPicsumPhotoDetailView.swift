//
//  LoremPicsumPhotoDetailView.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 12/1/25.
//

import SwiftUI

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
                    
                    Text("Author: \(photo.author)")
                        .font(.headline)
                        .accessibilityLabel("Author: \(photo.author)")
                    
                    Text("ID: \(photo.id)")
                        .accessibilityLabel("Photo ID: \(photo.id)")
                    
                    Text("Size: \(photo.width) by \(photo.height)")
                        .accessibilityLabel("Resolution: \(photo.width) by \(photo.height) pixels")
                    
                    VStack(alignment: .leading) {
                        Text("Original URL:")
                            .bold()
                            .accessibilityHidden(true)
                        
                        Text(photo.url)
                            .foregroundColor(.blue)
                            .textSelection(.enabled)
                            .accessibilityLabel("Original URL, link: \(photo.url)")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Download URL:")
                            .bold()
                            .accessibilityHidden(true)
                        
                        Text(photo.downloadURL)
                            .foregroundColor(.blue)
                            .textSelection(.enabled)
                            .accessibilityLabel("Download URL, link: \(photo.downloadURL)")
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Photo Detail")
        .accessibilityElement(children: .contain)
    }
}
