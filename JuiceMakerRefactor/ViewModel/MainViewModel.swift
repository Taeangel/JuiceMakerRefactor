//
//  MainViewModel.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/26.
//

import Foundation

class MainViewModel: ObservableObject {
  
  let fruitModel: FruitStockService
  
  init(
    fruitModel: FruitStockService = FruitStockService()
  ) {
    self.fruitModel = fruitModel
  }
}
