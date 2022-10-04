//
//  ContentView.swift
//  JournalSwiftUI
//
//  Created by Oskar Larsson on 2022-10-04.
//

import SwiftUI


struct ContentView: View {
    
    // Detta är ett objekt vi vill lyssna på. Detta görs bara en gång - när man skapar den.
    @StateObject var journal = Journal()
    @State var showPopup = false
    
    var body: some View {
        
        ZStack {
            
            mainContentView(journal: journal, showPopup: $showPopup)
            
            if showPopup {
                popupView(journal: journal, showPopup: $showPopup)
            }
            
            
        }
    }
}

struct popupView: View {
    
    @ObservedObject var journal: Journal
    @State var title = ""
    @State var description = ""
    @Binding var showPopup: Bool
    
    var body: some View {
        
        VStack {
            Text("Add entry")
                .font(.title)
                .bold()
                .padding(.top, 20)
            VStack(alignment: .leading) {
                Text("Ange titel")
                TextField("", text: $title) //Binding = det som ändras ändras i variabeln
                    .textFieldStyle(.roundedBorder)
                    .foregroundColor(.brown)
                
                Text("Ange beskrivning")
              
                
                if #available(iOS 13.0, *) {
                    TextEditor(text: $description)
                        .cornerRadius(7)
                        .padding(.bottom, 10)
                        .foregroundColor(.brown)
                }

                    HStack() {
                        Spacer()
                        Button(action: {
                            
                            if title == "" || description == "" {
                                return
                            }
                            
                            journal.addEntry(entry: JournalEntry(title: title, description: description, date: Date()))
                            
                            withAnimation{
                            showPopup = false
                            }
                          
                        }, label: {
                            Text("Save").bold()
                        }).padding().background(.white).foregroundColor(Color.brown)
                        Spacer()
                        Button(action: {
                            showPopup = false
                        }, label: {
                            Text("Cancel").bold()
                        })
                        Spacer()
                    
                }

            }.padding()
        }.frame(alignment: .center)
            .background(.ultraThinMaterial)
            .foregroundColor(.black)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding(20)
            .transition(.move(edge: .bottom))
        
    }
    
}

struct mainContentView: View {
    
    @ObservedObject var journal: Journal
    @Binding var showPopup: Bool
    
    var body: some View {
        
        VStack {
            Text("My Journal")
                .font(.title).bold()
            
            List(){
                ForEach(journal.getAllEntries()) {
                    entry in
                    
                    Text(entry.title)
                }
            }
            Button(action: {
                
                withAnimation{
                    showPopup = true
                    
                }
                
                print("Knappen är tryckt")
            }, label: {
                    Text("Knapp")
                    .bold()
                    
                    
            }).padding()
                .background(.brown).foregroundColor((.white))
                .cornerRadius(7)
            
            Spacer()
        }
   
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView()
        popupView(journal: Journal(), showPopup: .constant(true))
    }
}
