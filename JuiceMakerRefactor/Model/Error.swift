//
//  Error.swift
//  JuiceMakerRefactor
//
//  Created by song on 2022/08/14.
//

import Foundation

enum MakeJuiceError: Error {
  case outOfStock
  case notExistFruit
}

extension MakeJuiceError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .outOfStock:
      return "재료가 모자라요. 재고를 수정할까요?"
    case .notExistFruit:
      return "존재하지 않는 과일입니다."
    }
  }
}
