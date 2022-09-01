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
  @Published var isAlert: Bool
  var alertInformation: String
  private(set) var fruitInformation: [Fruit]
  private(set) var juiceInformation: [Juice: Bool]
  private var cancellable: Set<AnyCancellable>
  private let fruitModel: FruitStockService
  
  init(
    stock: [Fruit: Int] = [Fruit: Int](),
    isShowModal: Bool = false,
    isAlert: Bool = false,
    alertInformation: String = "",
    fruitInformation: [Fruit] = [Fruit](),
    JuiceInformation: [Juice: Bool] = [Juice: Bool](),
    cancellable: Set<AnyCancellable> = Set<AnyCancellable>(),
    fruitModel: FruitStockService
  ) {
    self.stock = stock
    self.isShowModal = isShowModal
    self.isAlert = isAlert
    self.alertInformation = alertInformation
    self.fruitInformation = fruitInformation
    self.juiceInformation = JuiceInformation
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
  }
  
  private func addSubscribers() {
    self.fruitModel.$stock
      .sink(receiveValue: { [weak self] returnValue in
        guard let self = self else { return }
        self.stock = returnValue
        
      })
      .store(in: &cancellable)
  }
  
  func addButtonSubscribers() {
    self.fruitModel.$stock
      .map({ _ -> [Juice :Bool] in
        self.fruitModel.canMakeAll()
      })
      .sink(receiveValue: { [weak self] returnValue in
        guard let self = self else { return }
        
        self.juiceInformation = returnValue
        
      })
      .store(in: &cancellable)
  }
  
  func make(_ juice: Juice)  {
    let result = fruitModel.make(juice)
    
    switch result {
    case .success(let juice):
      self.isAlert = true
      self.alertInformation = juice.description
    case .failure(let error):
      self.isAlert = true
      self.alertInformation = error.localizedDescription
    }
  }
}
