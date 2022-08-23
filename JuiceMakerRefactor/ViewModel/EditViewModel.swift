//
//  EditViewModel.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/22.
//

import Combine

class EdithViewModel: ObservableObject {
  private(set) var fruitInformation = [Fruit]()
  private let fruitStockService: FruitStockService
  private var cancellable = Set<AnyCancellable>()
  @Published var stock = [Fruit: Int]()
  
  init(fruitStockService: FruitStockService) {
    self.fruitStockService = fruitStockService
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
}
