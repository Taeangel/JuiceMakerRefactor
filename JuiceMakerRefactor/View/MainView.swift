//
//  MainView.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/26.
//

import SwiftUI

struct MainView: View {
  @StateObject var viewModel: MainViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  init() {
    self._viewModel = StateObject(wrappedValue: MainViewModel())
    Theme.navigationBarColors(background: .white, titleColor: .red)
  }
  
  var body: some View {
    VStack {
      if viewRouter.currentPage == "JuiceOrderView" {
        JuiceOrderView(service: viewModel.fruitModel)//호옹이
      }
      else if viewRouter.currentPage == "StockEditView" {
        StockEditView(service: viewModel.fruitModel)
      }
    }
  }
}
