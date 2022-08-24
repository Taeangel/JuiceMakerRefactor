//
//  EditView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/19.
//

import SwiftUI

struct EditView: View {
  @StateObject var viewModel: EdithViewModel
  
  init(service: FruitStockService, isShowMoadl: Binding<Bool>) {
    _viewModel = StateObject(wrappedValue: EdithViewModel(fruitStockService: service,
                                                          isShowModal: isShowMoadl))
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
            viewModel.isShowModal = false
          }, label: {
            Text("닫기")
          })
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}
