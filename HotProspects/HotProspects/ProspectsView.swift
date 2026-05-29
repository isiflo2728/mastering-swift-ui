//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Isidoro Flores on 5/27/26.
//

import SwiftUI
import SwiftData
import CodeScanner
internal import AVFoundation

enum FilterType {
    case none, contacted, uncontacted
    
}


struct ProspectsView: View {
    let filter : FilterType
    
    var title : String {
        switch filter {
        case .none:
            "Everyone"
        case.contacted:
            "Contacted People"
        case .uncontacted:
            "Uncontacted People"
        
        }
    }
    
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    
    init(filter: FilterType){
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            //et showContactedOnly to true if our filter is set to .contacted."
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
        
    }
    
    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    
    var body: some View {
        NavigationStack {
            List(prospects, selection: $selectedProspects){ prospect in
                VStack(alignment: .leading){
                    Text(prospect.name)
                        .font(.headline)
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                .swipeActions{
                    Button("Delete", systemImage: "trash", role: .destructive){
                        modelContext.delete(prospect)
                    }
                    if prospect.isContacted {
                        Button("Mark uncontacted", systemImage: "person.crop.circle.badge.xmark"){
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark contacted", systemImage: "person.crop.circle.fill.badge.checkmark"){
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                    }
                }
                .tag(prospect)
                
            }
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan", systemImage: "qrcode.viewfinder"){
                            isShowingScanner.toggle()
                        }
                    }
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                   
                }
                .safeAreaInset(edge: .bottom){
                    if selectedProspects.isEmpty == false {
                        Button("Delete Selected", action: delete)
                                      .padding()
                                      .frame(maxWidth: .infinity)
                                      .background(.regularMaterial)
                    }
                }

        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>){
        isShowingScanner = false
        switch result{
        case .success(let result):
            let details = result.string.components(separatedBy:"\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            }
        }
    func delete() {
        for prospect in selectedProspects{
            modelContext.delete(prospect)
        }
    }
    
}

#Preview {
    ProspectsView(filter: .none)
}
