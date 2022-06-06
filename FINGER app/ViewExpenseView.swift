//
//  ViewExpenseView.swift
//  FINGER app
//
//  Created by Maheswara Ananta Argono on 07/04/22.
//

import SwiftUI

struct ViewExpenseView: View {
    
    @Binding var expenses : [String:[Expense]]
    @Binding var totalExpense: [String:Int]

    init(expenses : Binding<[String:[Expense]]>, totalExpense : Binding<[String:Int]>) {
        self._expenses = expenses
        self._totalExpense = totalExpense
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                let date : String = getDate()
                if  totalExpense[date] != nil{
                    Text("Expense Total")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top,15)
                        .foregroundColor(Color.white)
                    Text("Rp.\(totalExpense[getDate()]!),-")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.bottom,-10)
                    List {
                        
                        Section {
                            ForEach(expenses[date]!, id: \.self) { expense in
                                ExpenseListView(expenseName: expense.name, expenseCost: "Rp.\(expense.cost),-", expenseAmount: "x\(expense.amount)")
                                        }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                else{
                    Text("Expense Total")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top,15)
                        .foregroundColor(Color.white)
                    Text("Rp. 0,-")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.bottom,-10)
                    List {
                        Section {
                            Text("There's no expense, input expense first!")
                            
                            
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .background(expenseColor)
            .navigationTitle("Monthly Summary")
            .navigationBarTitleDisplayMode(.inline)
        }.accentColor(Color.black)
    }
    
    func getDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        let thismonth = dateFormatter.string(from: date)
        
        return thismonth
    }
    
}

struct ViewExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyExpense : Expense = Expense(name: "ayefone", cost: 300000, amount: 3)
        let dummyExpense2 : Expense = Expense(name: "ayepot", cost: 550000, amount: 1)
        let dummyExpense3 : Expense = Expense(name: "ayecloud", cost: 100000, amount: 1)
        let dummyExpense4 : Expense = Expense(name: "ayepet", cost: 450000, amount: 1)
        let dummyExpense5 : Expense = Expense(name: "ayemac", cost: 1000000, amount: 1)
        let dummyDate : String = "April 2022"
        ViewExpenseView(expenses: .constant([dummyDate:[
            dummyExpense,
            dummyExpense2,
            dummyExpense3,
            dummyExpense4,
            dummyExpense5]]),
                        totalExpense: .constant(["April 2022" : 3000000]))
    }
}

//prints a section of expenses
struct ExpenseListView: View {
    var expenseName : String
    var expenseCost : String
    var expenseAmount : String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(expenseName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                Text(expenseCost)
                    .font(.title2)
            }
            Spacer()
            VStack {
                Text(expenseAmount)
                Spacer()
            }
        }
    }
}
