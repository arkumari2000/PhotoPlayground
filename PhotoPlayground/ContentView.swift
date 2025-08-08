//
//  ContentView.swift
//  PhotoPlayground
//
//  Created by Archana Kumari on 08/08/25.
//

import SwiftUI
import PhotosUI
import ImagePlayground

struct ContentView: View {
    
    @Environment(\.supportsImagePlayground) var supportsImagePlaygroud
    @State private var imageGenerationConcept = ""
    @State private var isShowingImagePlayground = false

    @State private var avatarImage: Image?
    @State private var photosPickerItem: PhotosPickerItem?

    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 20) {
                PhotosPicker(selection: $photosPickerItem, matching: .not(.screenshots)) {
                    (avatarImage ?? Image(systemName: "person.circle.fill"))
                        .resizable()
                        .foregroundStyle(.mint)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                }

                VStack(alignment: .leading) {
                    Text("Archana Kumari")
                        .font(.title.bold())

                    Text("iOS Developer").bold()
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            
            if supportsImagePlaygroud {
                TextField("Enter Avatar Description", text: $imageGenerationConcept)
                    .font(.title3.bold())
                    .padding()
                    .background(.quaternary, in: .rect(cornerRadius: 16, style: .continuous))
                
                Button("Generate AI Image", systemImage: "sparkels") {
                        isShowingImagePlayground = true
                }
                .padding()
                .foregroundStyle(.mint)
                .fontWeight(.bold)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(.mint, lineWidth: 3)
                )
            }

            Spacer()
        }
        .padding(30)
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) { avatarImage = Image(uiImage: image) }
                }
            }
        }
    }
}

#Preview { ContentView() }
