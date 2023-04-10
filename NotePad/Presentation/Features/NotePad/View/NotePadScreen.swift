//
//  NotePadScreen.swift
//  NotePad
//
//  Created by mac on 10/04/2023.
//

import SwiftUI
import SwiftUINavigator

struct NotePadScreen: View {
    @ObservedObject private var viewModel  : NotesListViewModel = NotesListDiContainer.notesListViewModel
    @EnvironmentObject private var navigator: Navigator
    @FocusState private var noteTextIsFocused: Bool

    
    init(note: Note) {
        self.viewModel.note = note
        self.viewModel.noteText = note.note ?? ""
    }
    
    var body: some View {
        NavigationView{
            VStack{

                ZStack(alignment: .leading) {
                    GeometryReader { geometry in
                        TextEditor( text: $viewModel.noteText)
                            .onChange(of: viewModel.noteText, perform: { newValue in
                                viewModel.note?.note = newValue
                            })
                            .focused($noteTextIsFocused)
                            .lineLimit(nil)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                                    
                    }
                    if viewModel.noteText.isEmpty {
                        VStack{
                            Text("Enter your text here")
                                .font(.custom("Helvetica", size: 20))
                                .padding(.all)
                                .onTapGesture {
                                    noteTextIsFocused = true
                                }
                            Spacer()

                        }.frame(height: .infinity)
                    }
                }.padding(8)
                
                
            }
                
                .navigationBarItems(leading: NavigationTitle(), trailing: SaveNoteButton())
        }
        .safeAreaInset(edge: .bottom) {
            OperaqtionView()
                .padding()
                .textFieldStyle(.roundedBorder)
                .background(.ultraThinMaterial)
        }
    }
        
     private func  OperaqtionView() -> some View {
           
         HStack{
             Spacer()
             Button {
                if let note = viewModel.note ,let notetxt = note.note ,   !notetxt.isEmpty  {
                     checkDeleteOperation(note: note)
                 }
             } label: {
                 HStack{
                     Text("Delete")
                     Spacer().frame(width: 4)
                     Image(systemName: "trash")
                 }
             }
             
             
             Spacer()
             
             Button {
                 if let note = viewModel.note ,let notetxt = note.note ,   !notetxt.isEmpty {
                     viewModel.shareNote(note: note)
                 }
             } label: {
                 HStack{
                     Text("Share")
                     Spacer().frame(width: 4)
                     Image(systemName: "square.and.arrow.up")
                 }
             }
             Spacer()
            
         }.frame(height: 30)
         
        }
    
    
    
    private func NavigationTitle() -> some View {
       
            Button {
                navigator.dismiss()
            } label: {
                HStack{
                    Image(systemName: "chevron.left")
                    Text("Notes")
                        .foregroundColor(Color.blue)
                        .font(.body)
                        .fontWeight(.bold)
                }
            }

            
    }
    
    private func SaveNoteButton() -> some View {
        Button(action: {
            if let note = viewModel.note ,let notetxt = note.note ,   !notetxt.isEmpty {
                viewModel.saveNote(note: note)
                navigator.dismiss()
            }
        }, label: {
            Text("Save")
                .foregroundColor(Color.blue)
                .font(.body)
                .fontWeight(.bold)
        })
    }
    
    
    private func checkDeleteOperation(note:Note) {
        navigator.presentAlert {
            Alert(title: Text("Are you sure to delete this note?"), message: Text(""), primaryButton:.cancel(),
                  secondaryButton:  .default(Text("Yes").fontWeight(.heavy),action: {
                viewModel.deleteNote(note: note)
                navigator.dismiss()
            })
                    )
        }
       
    }
    
    
    
        
}

struct NotePadScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotePadScreen(note: Note(id: UUID(), note: "test", date: .now))
    }
}
