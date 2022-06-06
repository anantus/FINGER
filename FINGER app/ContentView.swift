//
//  ContentView.swift
//  FINGER app
//
//  Created by Maheswara Ananta Argono on 05/04/22.
//

import SwiftUI

//Color variable
var primaryColor = Color.green
var expenseColor = Color.mint
var incomeColor = Color.cyan
var summaryColor = Color.blue



struct ContentView: View {
    
    //Variables
    @State private var expenses: [String:[Expense]] = [:]
    @State private var totalExpense: [String:Int] = [:]
    @State private var incomes: [String:[Income]] = [:]
    @State private var totalIncome: [String:Int] = [:]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("FINGER")
                    .font(.system(size: 72))
                    .fontWeight(.bold)
                
                Text("Monitor your financial \n expense and income")
                    .font(.title)
                    .padding(.bottom)
                ZStack{
                    RoundedRectangle(cornerRadius: 42)
                        .padding(.bottom, -100)
                        .foregroundColor(.white)
                    
                    VStack(spacing: 15){
                        Spacer().frame(height:20)
                        NavigationLink(destination: writeExpenseView(expenses: $expenses, totalExpense: $totalExpense)) {
                            ButtonMenu(title: "Write Expense", color: expenseColor)
                        }
                        NavigationLink(destination: ViewExpenseView(expenses: $expenses, totalExpense: $totalExpense)) {
                            ButtonMenu(title: "View Expense", color: expenseColor)
                        }
                        NavigationLink(destination: WriteIncomeView(incomes: $incomes, totalIncome: $totalIncome)) {
                            ButtonMenu(title: "Write Income", color: incomeColor)
                        }
                        NavigationLink(destination: ViewIncomeView(incomes: $incomes, totalIncome: $totalIncome)) {
                            ButtonMenu(title: "View Income", color: incomeColor)
                        }
                        NavigationLink(destination: MonthlySummaryView(totalExpense: $totalExpense, totalIncome: $totalIncome)) {
                            ButtonMenu(title: "Monthly Summary", color: summaryColor)
                        }
                        
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .background(primaryColor)
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonMenu: View {
    var title : String
    var color : Color
    
    init(title: String, color: Color){
        self.title = title
        self.color = color
    }
    var body: some View {
        Text(title)
        //font size
            .font(.title2)
            .fontWeight(.semibold)
        //frame
            .frame(width: 350, height: 85, alignment: .center)
        //color
            .background(color)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}
