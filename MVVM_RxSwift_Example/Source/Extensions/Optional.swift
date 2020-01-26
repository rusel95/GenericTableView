//
//  Optional.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation

extension Optional {

  public var isNone: Bool {
    if case .none = self {
      return true
    } else {
      return false
    }
  }
  
  public var isSome: Bool {
    if case .some(_) = self {
      return true
    } else {
      return false
    }
  }
  
  public func or(_ default: Wrapped) -> Wrapped {
    return self ?? `default`
  }
  
  public func or(else: @autoclosure () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }
  
  public func or(else: () -> Wrapped) -> Wrapped {
    return self ?? `else`()
  }
  
  public func or(throw exception: Error) throws -> Wrapped {
    guard let unwrapped = self else { throw exception }
    return unwrapped
  }
  
}

extension Optional where Wrapped == Error {

  public func or(_ else: (Error) -> Void) {
    guard let error = self else { return }
    `else`(error)
  }
  
}
