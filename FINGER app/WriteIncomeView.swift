//
//  WriteIncomeView.swift
//  FINGER app
//
//  Created by Maheswara Ananta Argono on 09/04/22.
//

import SwiftUI

struct WriteIncomeView: View {
    
    @State private var name : String = ""
    @State private var cost : String = ""
    @State private var amount : String = ""
    @State private var popupName : String = ""
    @Binding var incomes : [String:[Income]]
    @Binding var totalIncome: [String:Int]
    @Environment(\.presentationMode) var presentationMode
    
    
    init(incomes : Binding<[String:[Income]]>, totalIncome : Binding<[String:Int]>) {
        self._incomes = incomes
        self._totalIncome = totalIncome
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
                            TextField("income name", text: $name)
                        }
                        
                        HStack{
                            Text("Profit").padding(.trailing,25)
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
            .background(incomeColor)
            .navigationTitle(Text("Write Income"))
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save"){
                        addIncome(name: name, cost: Int(cost)!, amount: Int(amount)!)
                        print("\(incomes)")
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
    
    func addIncome(name:String, cost:Int, amount:Int){
        let currentDate : String = getDate()
        let newIncome : Income = Income(name: name, cost: cost, amount: amount)
        
        if  totalIncome[currentDate] == nil || totalIncome[currentDate] == 0{
            totalIncome[currentDate] = cost * amount
            incomes[currentDate] = [newIncome]
        }
        else{
            totalIncome[currentDate]! += cost * amount
            incomes[currentDate]!.insert(newIncome, at: 0)
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

struct WriteIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        WriteIncomeView(incomes: .constant([:]), totalIncome: .constant([:]))
    }
}

//struct for Income
struct Income : Hashable{
    
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
