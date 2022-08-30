//
//  EditViewModel.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/22.
//

import Combine
import SwiftUI

class StockEdithViewModel: ObservableObject {
  @Published var stock: [Fruit: Int]
  private(set) var fruitInformation: [Fruit]
  private let fruitStockService: FruitStockService
  private var cancellable: Set<AnyCancellable>
  
  init(
    fruitStockService: FruitStockService,
    fruitInformation: [Fruit] = [Fruit](),
    cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
    stock: [Fruit: Int] = [Fruit: Int]()
  
  ) {
    self.fruitStockService = fruitStockService
    self.fruitInformation = fruitInformation
    self.cancellable = cancellable
    self.stock = stock
    
    self.initsetting()
    self.addSubscribers()
  }
  
  private func initsetting() {
    
    for fruit in Fruit.allCases {
      fruitInformation.append(fruit)
    }
  }
  
  private func addSubscribers() {
    self.fruitStockService.$stock
      .sink { Completion in
        switch Completion {
        case .finished:
          break
        case .failure(let error):
          print("\(error)")
        }
      } receiveValue: { [weak self] returnValue in
        self?.stock = returnValue
      }
      .store(in: &cancellable)
  }
  
  func plusStock(of fruit: Fruit, _ value: Int) {
    fruitStockService.plusStock(of: fruit, value)
  }
  
  func minusStock(of fruit: Fruit, _ value: Int) {
    fruitStockService.minusStock(of: fruit, value)
  }
}
