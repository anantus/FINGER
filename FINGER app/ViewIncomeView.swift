//
//  ViewIncomeView.swift
//  FINGER app
//
//  Created by Maheswara Ananta Argono on 07/04/22.
//

import SwiftUI

struct ViewIncomeView: View {
    
    @Binding var incomes : [String:[Income]]
    @Binding var totalIncome: [String:Int]

    init(incomes : Binding<[String:[Income]]>, totalIncome : Binding<[String:Int]>) {
        self._incomes = incomes
        self._totalIncome = totalIncome
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        NavigationView {
            VStack {
                let date : String = getDate()
                if  totalIncome[date] != nil{
                    Text("Income Total")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top,15)
                        .foregroundColor(Color.white)
                    Text("Rp.\(totalIncome[getDate()]!),-")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.bottom,-10)
                    List {
                        
                        Section {
                            ForEach(incomes[date]!, id: \.self) { income in
                                IncomeListView(incomeName: income.name, incomeCost: "Rp.\(income.cost),-", incomeAmount: "x\(income.amount)")
                                        }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                else{
                    Text("Income Total")
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
                            Text("There's no income, input income first!")
                            
                            
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .background(incomeColor)
            .navigationTitle("View Income")
            .navigationBarTitleDisplayMode(.inline)
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

struct ViewIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyIncome : Income = Income(name: "Ngasdos", cost: 300000, amount: 3)
        let dummyIncome2 : Income = Income(name: "Project FINGER", cost: 550000, amount: 1)
        let dummyIncome3 : Income = Income(name: "Tokped", cost: 100000, amount: 1)
        let dummyIncome4 : Income = Income(name: "Trading Forex", cost: 450000, amount: 1)
        let dummyIncome5 : Income = Income(name: "ayepol dev", cost: 2000000, amount: 1)
        let dummyDate : String = "April 2022"
        ViewIncomeView(incomes: .constant([dummyDate:[
            dummyIncome,
            dummyIncome2,
            dummyIncome3,
            dummyIncome4,
            dummyIncome5]]),
                       totalIncome: .constant(["April 2022" : 4000000]))
    }
}

//prints a section of incomes
struct IncomeListView: View {
    var incomeName : String
    var incomeCost : String
    var incomeAmount : String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(incomeName)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.gray)
                Text(incomeCost)
                    .font(.title2)
            }
            Spacer()
            VStack {
                Text(incomeAmount)
                Spacer()
            }
        }
    }
}
