//
//  MonthlySummaryView.swift
//  FINGER app
//
//  Created by Maheswara Ananta Argono on 08/04/22.
//

import SwiftUI

struct MonthlySummaryView: View {
    @Binding var totalExpense: [String:Int]
    @Binding var totalIncome: [String:Int]
    
    var body: some View {
        NavigationView {
            VStack {
                let currentDate : String = getDate()
                let currentExpense : Int = totalExpense[currentDate] ?? 0
                let currentIncome : Int = totalIncome[currentDate] ?? 0
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.bottom,20)
                        .padding(.top,20)
                    VStack(spacing: 15){
                        Text("Monthly Balance")
                            .font(.title2)
                            .fontWeight(.bold)
                        if currentIncome >= currentExpense{
                            Text("+ Rp.\(currentIncome-currentExpense),-")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.green)
                        }
                        else{
                            Text("- Rp.\(abs(currentIncome-currentExpense)),-")
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(.red)
                        }
                        
                    }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 42)
                        .foregroundColor(.white)
                        .padding()
                    VStack(spacing: 15){
                        Text("Expense Total")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        Text("Rp.\(currentExpense),-")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("List of Monthly Expense")
                            .fontWeight(.semibold)
                            //frame
                            .frame(width: 250, height: 40, alignment: .center)
                            //color
                            .background(expenseColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 42)
                        .foregroundColor(.white)
                        .padding()
                    VStack(spacing: 15){
                        Text("Income Total")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        Text("Rp.\(currentIncome),-")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("List of Monthly Income")
                            .fontWeight(.semibold)
                            //frame
                            .frame(width: 250, height: 40, alignment: .center)
                            //color
                            .background(incomeColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                }
                            
            }
            .background(Color.blue)
            .navigationTitle("Monthly Summary")
        }.accentColor(.black)
    }
    
    func getDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL yyyy"
        let thismonth = dateFormatter.string(from: date)
        
        return thismonth
    }
    
}

struct MonthlySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySummaryView(totalExpense: .constant(["April 2022": 2500000]), totalIncome: .constant(["April 2022":3000000]))
    }
}
