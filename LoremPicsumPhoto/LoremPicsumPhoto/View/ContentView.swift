//
//  ContentView.swift
//  LoremPicsumPhoto
//
//  Created by Pierre ILYAMUKURU on 11/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoremPicsumPhotoViewModel()
    
    let spacing: CGFloat = 16
    let imageHeight: CGFloat = 150
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                let screenWidth = geo.size.width
                let imageWidth = (screenWidth - spacing * 3) / 2
                
                ScrollView {
                    LazyVGrid(
                        columns: [
                            GridItem(.fixed(imageWidth), spacing: spacing),
                            GridItem(.fixed(imageWidth), spacing: spacing)
                        ],
                        spacing: spacing
                    ) {
                        ForEach(viewModel.loremPicsumPhotos) { photo in
                            
                            NavigationLink(destination: LoremPicsumPhotoDetailView(photo: photo)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    AsyncImage(url: URL(string: photo.downloadURL)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: imageWidth, height: imageHeight)
                                    .clipped()
                                    .accessibilityLabel("Photo by \(photo.author)")
                                    .accessibilityHint("Double tap to view details")
                                }
                            }
                            .buttonStyle(.plain)
                            .accessibilityElement(children: .combine)
                            .onAppear {
                                Task {
                                    await viewModel.loadNextLoremPicsumPage(photo: photo)
                                }
                            }

                        }
                    }
                    .padding(.horizontal, spacing)
                    .padding(.top, spacing)
                }
                .navigationTitle("Photos")
            }
        }
        .task {
            await viewModel.loadLoremPicsumFromStart()
        }
    }
}

#Preview {
    ContentView()
}
