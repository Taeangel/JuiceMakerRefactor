//
//  FruitStore.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import UIKit
import Combine

class fruitStockService {
  @Published var stock = [Fruit: Int]()
  
  init() {
    initsetting()
  }
  
  private func initsetting() {
    let defaultCount = 10
    
    for fruit in Fruit.allCases {
      stock[fruit] = defaultCount
    }
  }
  
  private func checkStock(of fruits: [Fruit: Int]) -> Bool {
    return fruits.keys
      .filter { stock.keys.contains($0) }
      .count == fruits.count
  }
  
  private func canMake(_ fruits: [Fruit: Int]) -> Bool {
    return self.stock
      .merging(fruits) { $0 - $1 }
      .filter { $0.value < Int.zero }
      .count == Int.zero
  }
  
  private func consumeStock(of fruits: [Fruit: Int]) {
    stock.merge(fruits) { $0 - $1 }
  }
  
  func setStock(of fruit: Fruit, _ value: Int) {
    stock[fruit] = value
  }
  
  func make(_ juice: Juice) -> Result<Juice, MakeJuiceError> {
    let recipe = juice.recipe
    guard checkStock(of: recipe) else {
      return .failure(.notExistFruit)
    }
    guard canMake(recipe) else {
      print("모잘라요")
      return .failure(.outOfStock)
      
    }
    consumeStock(of: recipe)
    return .success(juice)
  }
}

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
