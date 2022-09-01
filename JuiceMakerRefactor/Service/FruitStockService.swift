//
//  FruitStockService.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/22.
//

import SwiftUI

class FruitStockService {
  @Published var stock: [Fruit: Int]
  
  init(stock: [Fruit: Int] = [Fruit: Int]()) {
    self.stock = stock
    initsetting()
  }
  
  private func initsetting() {
    let defaultCount = 99
    
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
  
  func canMake2(_ fruits: [Fruit: Int]) -> Bool {
    return self.stock
      .merging(fruits) { $0 - $1 }
      .merging(fruits) { $0 - $1 }
      .filter { $0.value < Int.zero }
      .count == Int.zero
  }
  
  func canMakeAll() -> [Juice: Bool] {
    var buttonVaild: [Juice: Bool] = [:]
   
    for i in Juice.allCases {
      buttonVaild.updateValue(canMake2(i.recipe), forKey: i)
    }
    return buttonVaild
  }
  
  private func consumeStock(of fruits: [Fruit: Int]) {
    stock.merge(fruits) { $0 - $1 }
  }
  
  private func isPlusStock(of fruit: Fruit) -> Bool {
    return stock[fruit] != 99
  }
  
  private func isMinusStock(of fruit: Fruit) -> Bool {
    return stock[fruit] != 0
  }
  
  func plusStock(of fruit: Fruit, _ value: Int) {
    guard isPlusStock(of: fruit) else {
      return
    }
    
    let newValue = stock[fruit].map { $0 + value }
    
    stock[fruit] = newValue
  }
  
  func minusStock(of fruit: Fruit, _ value: Int) {
    guard isMinusStock(of: fruit) else {
      return
    }
    
    let newValue = stock[fruit].map { $0 - value }
    
    stock[fruit] = newValue
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
