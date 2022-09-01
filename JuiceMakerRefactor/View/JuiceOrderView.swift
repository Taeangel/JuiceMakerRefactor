//
//  ContentView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import SwiftUI

struct JuiceOrderView: View {
  @StateObject var viewModel: JuiceOrderViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  init(service: FruitStockService) {
    self._viewModel = StateObject(wrappedValue: JuiceOrderViewModel(fruitModel: service) )
  }
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          ForEach(viewModel.fruitInformation, id: \.self) { fruit in
            VStack{
              Image(uiImage: UIImage(named: fruit.name) ?? UIImage())
                .resizable()
                .frame(width: 100, height: 100)
              Text("\(viewModel.stock[fruit] ?? 0)")
            }
            .padding(30)
          }
        }
        
        HStack {
          ForEach(viewModel.juiceInformation.keys.sorted(by: <), id: \.self) { juice in
            Button(action: {
              viewModel.make(juice)
           }, label: {
             Text("\(juice.rawValue) 버튼")
           })
            .disabled(!viewModel.juiceInformation[juice]!)
          }
          .padding(30)
          .alert("\(viewModel.alertInformation)", isPresented: $viewModel.isAlert, actions: {})
        }
      }
      .navigationTitle("맛잇는 쥬스를 만들어 드려요!")
      
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            viewRouter.currentPage = "StockEditView"
          }, label: {
            Text("edit")
          })
//          .sheet(isPresented: $viewModel.isShowModal) {
//            StockEditView(service: viewModel.fruitModel)
//          }
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}


