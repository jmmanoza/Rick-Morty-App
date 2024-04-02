//
//  MainView.swift
//  Rick&MortyApp
//
//  Created by jmmanoza on 4/2/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var vm = MainViewModel(service: CharacterDataService())
    
    var body: some View {
        NavigationStack {
            VStack {
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(vm.characters, id: \.self) { character in
                                NavigationLink(value: character) {
                                    configCard(with: character)
                                        .padding(.all, 12)
                                }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Rick&Morty App")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .navigationDestination(for: Character.self) { character in
                DetailsView(id: character.id)
                    .navigationBarHidden(true)
            }
            .task {
                await vm.getAllCharacters()
            }
        }
    }
}

private extension MainView {
    @ViewBuilder
    func configCard(with character: Character) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: character.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .background(Color(.systemGray5))
                }
              
                VStack(alignment: .leading, spacing: 8) {
                    // name
                    Text(character.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    HStack(spacing: 4) {
                        Circle()
                            .foregroundColor(character.status == "Alive" ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        Text(character.status.capitalized)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom)
                    
                    // last known location
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Last known location:")
                        Text(character.location.name)
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color(.label))
                    
                    // first seen in
                    VStack(alignment: .leading, spacing: 8) {
                        Text("First seen in:")
                        Text(character.origin.name)
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color(.label))
                }
                .foregroundColor(Color(.label))
                
                Spacer()
            }
        }
        .frame(height: 150)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
