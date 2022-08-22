//
//  FruitStore.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import Combine

class MainViewModel: ObservableObject {
  
  @Published var stock = [Fruit: Int]()
  private(set) var fruitInformation = [Fruit]()
  private(set) var JuiceInformation = [Juice]()
  private var cancellable = Set<AnyCancellable>()
  private let fruitModel = fruitStockService()
  
  init() {
    initsetting()
    addSubscribers()
  }
  
  private func initsetting() {
    
    for fruit in Fruit.allCases {
      fruitInformation.append(fruit)
    }
    
    for juice in Juice.allCases {
      JuiceInformation.append(juice)
    }
  }
  
  private func addSubscribers() {
    self.fruitModel.$stock
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
  
  func make(_ juice: Juice) {
    fruitModel.make(juice)
  }
}
