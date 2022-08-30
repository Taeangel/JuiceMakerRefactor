//
//  EditView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/19.
//

import SwiftUI

struct StockEditView: View {
  @StateObject var viewModel: StockEdithViewModel
  @EnvironmentObject var viewRouter: ViewRouter

  init(service: FruitStockService) {
    self._viewModel = StateObject(wrappedValue: StockEdithViewModel(fruitStockService: service))
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
              Stepper("여기엔 멀써야 될까????",
                      onIncrement: {
                viewModel.plusStock(of: fruit, 1)
              },
                      onDecrement: {
                viewModel.minusStock(of: fruit, 1)
              })
            }
            .padding(30)
          }
        }
      }
      .navigationTitle("재고 추가")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {
            viewRouter.currentPage = "JuiceOrderView"
          }, label: {
            Text("닫기")
          })
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}
