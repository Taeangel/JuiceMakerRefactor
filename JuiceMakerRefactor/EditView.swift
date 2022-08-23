//
//  EditView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/19.
//

import SwiftUI

struct EditView: View {
  @StateObject var viewModel: EdithViewModel
  
  init(service: FruitStockService) {
    _viewModel = StateObject(wrappedValue: EdithViewModel(fruitStockService: service))
  }
  
  var body: some View {
    
    NavigationView {
      VStack {
        
      }
      .navigationTitle("재고 추가")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: {

          }, label: {
            Text("닫기")
          })
        }
      }
    }
    .navigationViewStyle(.stack)
  }
}
