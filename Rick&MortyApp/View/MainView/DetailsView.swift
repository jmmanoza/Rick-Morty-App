//
//  DetailsView.swift
//  Rick&MortyApp
//
//  Created by jmmanoza on 4/2/24.
//

import SwiftUI

struct DetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = MainViewModel(service: CharacterDataService())
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        ScrollView {
            headerView
                .padding()
            
            infoView
        }
        .ignoresSafeArea()
        .task {
            await vm.getSingleCharacter(with: id)
        }
    }
}

private extension DetailsView {
    @ViewBuilder
    var headerView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).minY
            let isScrolled = offsetY > 0
   
            
            Spacer()
                .frame(height: isScrolled ? 400 + offsetY: 400)
                .background {
                    AsyncImage(url: URL(string: vm.character?.image ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .offset(y: isScrolled ? -offsetY: 0)
                    } placeholder: {
                        Rectangle()
                            .background(Color(.systemGray5))
                    }
                }
            
            Button(action: {
                dismiss()
            }) {
                Image("icCircBlack")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding(.top, 32)
        }
        .frame(height: 400)
    }
    
    @ViewBuilder
    var infoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            // name
            Text(vm.character?.name ?? "")
                .font(.headline)
                .fontWeight(.bold)
            HStack(spacing: 4) {
                Circle()
                    .foregroundColor(vm.character?.status == "Alive" ? Color.green : Color.red)
                    .frame(width: 10, height: 10)
                Text(vm.character?.status.capitalized ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom)
            
            // details
            VStack(alignment: .leading, spacing: 8) {
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum" )
            }
            .font(.subheadline)
            .foregroundColor(Color(.label))
            
        }
        .foregroundColor(Color(.label))
        .padding(.horizontal)
    }
}
