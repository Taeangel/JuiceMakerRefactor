//
//  FruitStore.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import Combine

class JuiceOrderViewModel: ObservableObject {
  
  @Published var stock: [Fruit: Int]
  @Published var isShowModal: Bool
  @Published var isButtonValid: [Bool]
  private(set) var fruitInformation: [Fruit]
  private(set) var JuiceInformation: [Juice]
  private var cancellable: Set<AnyCancellable>
  private let fruitModel: FruitStockService
  
  init(
    stock: [Fruit: Int] = [Fruit: Int](),
    isShowModal: Bool = false,
    isButtonValid: [Bool] = [true, true, true, true, true, true, true],
    fruitInformation: [Fruit] = [Fruit](),
    JuiceInformation: [Juice] = [Juice](),
    cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
    fruitModel: FruitStockService
  ) {
    self.stock = stock
    self.isShowModal = isShowModal
    self.isButtonValid = isButtonValid
    self.fruitInformation = fruitInformation
    self.JuiceInformation = JuiceInformation
    self.cancellable = cancellable
    self.fruitModel = fruitModel
    
    initsetting()
    addSubscribers()
    addButtonSubscribers()
  }
  
  private func initsetting() {
    
    for fruit in Fruit.allCases {
      fruitInformation.append(fruit)
    }
    
    for juice in Juice.allCases {
      JuiceInformation.append(juice)
    }
    
    isButtonValid = fruitModel.canAllMake()
  }
  
  private func addSubscribers() {
    self.fruitModel.$stock
      .sink(receiveValue: { [weak self] returnValue in
        self?.stock = returnValue
        
      })
      .store(in: &cancellable)
  }
  
  func addButtonSubscribers() {
    self.fruitModel.$stock
      .map({ _ -> [Bool] in
        self.fruitModel.canAllMake()
      })
      .sink(receiveValue: { [weak self]  returnValue in
        guard let self = self else { return }
        print(returnValue)
        self.isButtonValid = returnValue
      })
      .store(in: &cancellable)
  }
  
  func make(_ juice: Juice) {
    fruitModel.make(juice)
  }
}
