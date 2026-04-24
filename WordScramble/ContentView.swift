//
//  ContentView.swift
//  WordScramble
//
//  Created by Isidoro Flores on 4/24/26.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        NavigationStack{
            List {
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)//so that words dont get capitalized autmatically
                }
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
              
            }
            .navigationTitle(rootWord)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Start"){
                        startGame()
                    }
                }
            }
       
        }
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {} message: {Text(errorMessage)}
        
        
    }
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordErro(title: "Word used Already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordErro(title: "Word not possibke", message: "You cant spell that word from \(rootWord)")
            return
        }
        
        guard isReal(word: answer) else {
            wordErro(title: "Word not recognized", message: "You cant just make them up, ya know...retard josh")
            return
        }
        
        guard isLong(word: answer) else{
            wordErro(title: "Ouch word not long enough", message: "Not long enough is a recurring issue huh?")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
            
        }
        fatalError("Could not load start.txt frombundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLong(word: String) -> Bool{
        if word == rootWord || word.count <= 3{
            return false
        }
        
        return true
    }
    
    func wordErro(title: String , message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
  
    
}
   

#Preview {
    ContentView()
}

/*
 this is how u load a url into a string
 if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt"){
     
     if let fileContents = try? String(contentsOf: fileURL){
         
     }
     
 }
 
 this is how we can spell chekc workds
 
 first we make a wore
 let timmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
 let word = "swift"
 we create an instanve of UIText checker whoch comes from uikit
 let checker = UITextChecker()
 
 next we provide our rance and weather our spell checker should loop around
 let range = NSRange(location: 0, length: word.utf16.count)
 let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
 then we store the value of oura api in a variable the NSNotFound is uikits verison of nil it is objective-c
 let allGood = misspelledRange.location == NSNotFound
 // on submit modifier needs a  funciton that has no parameters and returns nothing
 */
