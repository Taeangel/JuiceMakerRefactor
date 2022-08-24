//
//  FruitStore.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import Combine

class MainViewModel: ObservableObject {
  
  @Published var stock: [Fruit: Int]
  @Published var isShowModal: Bool
  private(set) var fruitInformation: [Fruit]
  private(set) var JuiceInformation: [Juice]
  private var cancellable: Set<AnyCancellable>
  let fruitModel: FruitStockService
  
  init(
    stock: [Fruit: Int] = [Fruit: Int](),
    isShowModal: Bool = false,
    fruitInformation: [Fruit] = [Fruit](),
    JuiceInformation: [Juice] = [Juice](),
    cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
    fruitModel: FruitStockService = FruitStockService()
  ) {
    self.stock = stock
    self.isShowModal = isShowModal
    self.fruitInformation = fruitInformation
    self.JuiceInformation = JuiceInformation
    self.cancellable = cancellable
    self.fruitModel = fruitModel
    
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
