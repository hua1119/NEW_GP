//
//  MyrecipeView.swift
//  Graduation_Project
//
//  Created by Ｍac on 2023/8/30.
//

import SwiftUI

struct Note: Identifiable
{
    let id = UUID()
    var title: String
    var content: String
}

class NoteManager: ObservableObject
{
    @Published var notes: [Note] = []
    
    func addNote(title: String, content: String)
    {
        notes.append(Note(title: title, content: content))
    }
}


struct MyrecipeView: View
{
    
    @StateObject private var noteManager = NoteManager()
    @State private var isCreatingNote = false
    @State private var newNoteTitle = ""
    @State private var newNoteContent = ""
    
    var body: some View
    {
        //MARK: 記事本功能
        NavigationStack
        {
            List
            {
                ForEach(noteManager.notes)
                {
                    note in
                    NavigationLink(destination: EditNoteView(note: note, noteManager: noteManager))
                    {
                        Text(note.title)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationBarTitle("記事本")
            .navigationBarItems(trailing:
                                    Button(action:
                                            {
                // 初始化新記事本內容
                newNoteTitle = ""
                newNoteContent = ""
                isCreatingNote = true
            }) {
                Image(systemName: "plus")
            }
            )
        }
        
        //MARK: 新建記事本的畫面
        .sheet(isPresented: $isCreatingNote, content:
                {
            NavigationStack
            {
                VStack
                {
                    //  新建記事本的標題
                    TextField("標題", text: $newNoteTitle)
                        .padding()
                    //  新建記事本的內容
                    TextEditor(text: $newNoteContent)
                        .padding()
                    Button("建立")
                    {
                        noteManager.addNote(title: newNoteTitle, content: newNoteContent)
                        isCreatingNote = false
                    }
                    .padding()
                }
                .navigationBarTitle("新建")
            }
        })
    }
    //MARK: 刪除記事本
    func deleteNote(at offsets: IndexSet) {
        noteManager.notes.remove(atOffsets: offsets)
    }
}

//MARK: 編輯記事本
struct EditNoteView: View
{
    
    var note: Note
    
    @ObservedObject var noteManager: NoteManager
    
    @State private var editedTitle: String
    @State private var editedContent: String
    @State private var isEditNote = true
    
    @Environment(\.presentationMode) var presentationMode
    
    init(note: Note, noteManager: NoteManager)
    {
        self.note = note
        self.noteManager = noteManager
        _editedTitle = State(initialValue: note.title)
        _editedContent = State(initialValue: note.content)
    }
    
    var body: some View
    {
        //MARK: 編輯記事本畫面
        NavigationStack
        {
            VStack
            {
                //  編輯記事本的標題
                TextField("標題", text: $editedTitle)
                    .padding()
                //  編輯記事本的內容
                TextEditor(text: $editedContent)
                    .padding()
                Button("儲存")
                {
                    if let index = noteManager.notes.firstIndex(where: { $0.id == note.id })
                    {
                        noteManager.notes[index].title = editedTitle
                        noteManager.notes[index].content = editedContent
                        isEditNote = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .foregroundColor(.orange) // 進入編輯後儲存的顏色為綠色
                .padding()
            }
            .navigationBarTitle("編輯")
        }
    }
}

struct MyrecipeView_Previews: PreviewProvider {
    static var previews: some View {
        MyrecipeView()
    }
}
