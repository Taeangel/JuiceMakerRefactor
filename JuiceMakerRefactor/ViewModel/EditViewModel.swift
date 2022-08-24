//
//  EditViewModel.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/22.
//

import Combine
import SwiftUI

class EdithViewModel: ObservableObject {
  private(set) var fruitInformation: [Fruit]
  private let fruitStockService: FruitStockService
  private var cancellable: Set<AnyCancellable>
  @Published var stock: [Fruit: Int]
  @Binding var isShowModal: Bool
  
  init(
    fruitStockService: FruitStockService,
    isShowModal: Binding<Bool>,
    fruitInformation: [Fruit] = [Fruit](),
    cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
    stock: [Fruit: Int] = [Fruit: Int]()
  
  ) {
    self.fruitStockService = fruitStockService
    self._isShowModal = isShowModal
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
