//
//  writeExpenseView.swift
//  FINGER app
//
//  Created by Maheswara Ananta Argono on 07/04/22.
//

import SwiftUI

struct writeExpenseView: View {
    
    @State private var name : String = ""
    @State private var cost : String = ""
    @State private var amount : String = ""
    @State private var popupName : String = ""
    @Binding var expenses : [String:[Expense]]
    @Binding var totalExpense: [String:Int]
    @Environment(\.presentationMode) var presentationMode
    
    init(expenses : Binding<[String:[Expense]]>, totalExpense : Binding<[String:Int]>) {
        self._expenses = expenses
        self._totalExpense = totalExpense
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView{
            VStack {
                Text("")
                Text(popupName)
                List {
                    Section {
                        HStack{
                            Text("Name").padding(.trailing,22)
                            Spacer()
                            TextField("expense name", text: $name)
                        }
                        
                        HStack{
                            Text("Cost").padding(.trailing,32)
                            TextField("123456", text: $cost)
                                .keyboardType(.numberPad)
                        }
                        
                        HStack{
                            Text("Amount").padding(.trailing,7)
                            TextField("3", text: $amount)
                                .keyboardType(.numberPad)
                        }
                        
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .background(Color.mint)
            .navigationTitle(Text("Write Expense"))
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        addExpense(name: name, cost: Int(cost)!, amount: Int(amount)!)
                        print("\(expenses)")
                        popupName = "\(name) has been added!"
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back"){
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color.black)
        
    }
    
    func addExpense(name:String, cost:Int, amount:Int){
        let currentDate : String = getDate()
        let newExpense : Expense = Expense(name: name, cost: cost, amount: amount)
        
        if  totalExpense[currentDate] == nil || totalExpense[currentDate] == 0{
            totalExpense[currentDate] = cost * amount
            expenses[currentDate] = [newExpense]
        }
        else{
            totalExpense[currentDate]! += cost * amount
            expenses[currentDate]!.insert(newExpense, at: 0)
        }
        
    }
    
    func getDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        let thismonth = dateFormatter.string(from: date)
        
        return thismonth
    }
    
}

struct writeExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        writeExpenseView(expenses: .constant([:]), totalExpense: .constant([:]))
    }
}

//struct for Expense
struct Expense : Hashable{
    
    var name : String
    var cost : Int
    var amount : Int
    var date : String
    
    init(name:String, cost:Int, amount:Int){
        self.name = name
        self.cost = cost
        self.amount = amount
        
        //create month and year date
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        self.date = dateFormatter.string(from: date)
    }
}

