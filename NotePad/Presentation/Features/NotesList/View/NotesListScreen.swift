//
//  NotesListScreen.swift
//  NotePad
//
//  Created by mac on 09/04/2023.
//

import SwiftUI
import SwiftUINavigator

struct NotesListScreen: View {
    @ObservedObject private var viewModel  : NotesListViewModel = NotesListDiContainer.notesListViewModel
    @EnvironmentObject private var navigator: Navigator

    @State var selectedNote:Note?
    @State private var showActionSheet = false

    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(viewModel.notes) { item in
                        noteItemView(note: item)
                    }
                }
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
                .listStyle(.plain)
                .navigationBarItems(leading: NavigationTitle(), trailing: AddNoteButton())
                .actionSheet(isPresented: $showActionSheet, content: {
                    ActionSheet(title: Text(""),
                            message: Text(""),
                            buttons: [
                        .default(Text("Share")) {
                            guard let selectedNote = selectedNote else{return}
                            viewModel.shareNote(note: selectedNote)
                            } ,
                        .default(Text("Delete")) {
                            guard let selectedNote = selectedNote else{return}
                            checkDeleteOperation(note:selectedNote )
                            },
                        .default(Text("Edit")) {
                            guard let selectedNote = selectedNote else{return}
                            showNotePadScreen(note: selectedNote)
                        }  ,
                      .cancel()
                    ])
                })
                
                
                
                
                
                
            }
            
            
            
            

        }
        .navigationBarTitle("Notes")
        .task {
            await viewModel.loadNotes()
        }
    }



    private func noteItemView(note:Note) -> some View {
        ZStack(alignment: .bottomTrailing){
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Text(note.note ?? "")
                        .padding(8)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                Spacer()
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 8)
            .padding(.top, 12)
            
            
        }.onTapGesture {
            showNotePadScreen(note: note)
        }.onLongPressGesture {
            showActionSheet = true
            selectedNote = note
        }

        
       
        
    }
    
    
    private func NavigationTitle() -> some View {
        Text("Notepad")
            .foregroundColor(Color.black)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    private func AddNoteButton() -> some View {
        Button(action: {
            showNotePadScreen(note: Note(id: UUID()))
        }, label: {
            Label("Add", systemImage: "note.text.badge.plus")
        })
    }
    
    
    private func checkDeleteOperation(note:Note) {
        navigator.presentAlert {
            Alert(title: Text("Are you sure to delete this note?"), message: Text(""), primaryButton:.cancel(),
                  secondaryButton:  .default(Text("yes").fontWeight(.heavy),action: {
                viewModel.deleteNote(note: note)
            })
                    )
        }
       
    }
    
    
    private func showNotePadScreen(note:Note){
        navigator.navigate {
            NotePadScreen(note: note)
        }
    }
    
    
    
    



           }


struct NotesListScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotesListScreen()
    }
}

