//
//  ContentView.swift
//  WordCounter
//
//  Created by Arrr Park on 2022/04/27.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.presentationMode) var presentation
    
    @StateObject var homeViewModel: HomeViewModel
    
    private let gridItem = [GridItem(.fixed(Util.screenBounds.width))]
    
    init(directory: String) {
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(directory: directory))
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    HomeOptionBar(presentation: presentation).environmentObject(homeViewModel)
                    
                    let offset: CGFloat = homeViewModel.choiceHidden ? 0 : 50
                    ScrollView {
                        LazyVGrid(columns: gridItem, spacing: 0) {
                            ForEach(Array(homeViewModel.files.indices), id: \.self) { index in
                                let file = homeViewModel.files[index]
                                if file.isDirectory {
                                    if homeViewModel.choiceHidden {
                                        let directory = "\(homeViewModel.directory)/\(file.fileName)"
                                        NavigationLink(destination: HomeView(directory: directory).navigationBarHidden(true)) {
                                            FileListItem(file: file, index: index).environmentObject(homeViewModel)
                                        }
                                    } else {
                                        FileListItem(file: file, index: index).environmentObject(homeViewModel)
                                    }
                                } else {
                                    if homeViewModel.choiceHidden {
                                        NavigationLink(destination: WritingView(directory: homeViewModel.directory, fileName: file.fileName, onSaved: { homeViewModel.readFiles() }).navigationBarHidden(true)) {
                                            FileListItem(file: file, index: index).environmentObject(homeViewModel)
                                        }
                                    } else {
                                        FileListItem(file: file, index: index).environmentObject(homeViewModel)
                                    }
                                }
                            }
                        }
                    }.frame(maxHeight: Util.screenBounds.height - safeAreaInsets.top - safeAreaInsets.bottom - 40 - offset)
                    Spacer()
                }
                .frame(height: Util.screenBounds.height - safeAreaInsets.top - safeAreaInsets.bottom)
                .padding(.top, safeAreaInsets.top).padding(.bottom, safeAreaInsets.bottom)
                NavigationLink(destination: WritingView(directory: homeViewModel.directory, onSaved: { homeViewModel.readFiles() })
                    .navigationBarHidden(true)) {
                        Image(systemName: "plus")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFill()
                            .padding()
                            .foregroundColor(.white)
                            .background(Color(Colors.getColor(hex: Colors.deepGreen.rawValue)))
                            .cornerRadius(35)
                    }
                    .frame(width: 70, height: 70)
                    .offset(x: -25, y: -75)
                if !homeViewModel.createFolderViewHidden {
                    CreateFolderView().environmentObject(homeViewModel)
                }
                if !homeViewModel.choiceHidden {
                    HomeBottomOptionBar().environmentObject(homeViewModel)
                }
                if !homeViewModel.directoryViewHidden {
                    DirectoryView().environmentObject(homeViewModel)
                }
                if !homeViewModel.bottomSheetHidden {
                    GeometryReader { geometry in
                        Color.black.opacity(0.5)
                        BottomSheetView(
                            maxHeight: 300 + safeAreaInsets.bottom
                        ) {
                            OrderBySelectionView()
                                .background(Color.blue)
                                .environmentObject(homeViewModel)
                        }
                    }.onTapGesture {
                        homeViewModel.bottomSheetHidden = true
                    }.edgesIgnoringSafeArea(.all)
                }
            }.ignoresSafeArea().alert(isPresented: $homeViewModel.showAlert) {
                Alert(title: Text("Warning"),
                      message: Text("Do you want to delete selected files? This cannot be undone."),
                      primaryButton: .default(Text("Cancel"), action: {
                    homeViewModel.showAlert = false
                }), secondaryButton: .default(Text("Confirm"), action: {
                    homeViewModel.showAlert = false
                    if homeViewModel.removeFiles() {
                        homeViewModel.readFiles()
                    }
                }))
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(.stack).onAppear {
            homeViewModel.readFiles()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(directory: "Home")
        }
    }
}
