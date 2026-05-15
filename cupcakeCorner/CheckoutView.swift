//
//  CheckoutView.swift
//  cupcakeCorner
//
//  Created by Isidoro Flores on 5/13/26.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    var order = Order()
    func placeOrder() async {
        //encode order into a json
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return 
        }
        
        let url = URL(string: "https://httpbin.org/post")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for : request, from : encoded)
            print(String(data: data, encoding: .utf8) ?? "no response")
            let decodedOrder = try JSONDecoder().decode(Order.self, from : data)
            confirmationMessage = "Your order id is \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcake is on its way!"
            showConfirmation = true
        } catch {
            confirmationMessage = "Your order for \(order.quantity) x \(Order.types[order.type].lowercased()) cupcakes is on its way!"
                 showConfirmation = true
            
        }
    }
    var body: some View {
        ScrollView {
            VStack{
                AsyncImage(url : URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place order",){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check  out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showConfirmation){
            Button("Ok"){}
            
        } message: {
            Text(confirmationMessage)
        }
        
    }
}

#Preview {
    CheckoutView(order : Order() )
}


/*
 Button doesnt want to wait efor an async operation
 button cant wait so an await modifier is useles
 normally the on appear or task modifier will work but again we are clicking a button
 so our app needs to perform an action
 because of this we can just inbed a Task {await code function here}
 
 Post request
 
 let url = URL(string: "https://reqres.in/api/cupcakes")!
 var request = URLRequest(url: url)
 request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 request.httpMethod = "POST"
 
 
 */
