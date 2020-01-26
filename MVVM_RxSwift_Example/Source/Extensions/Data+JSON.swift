//
//  Dictionary+JSON.swift
//
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Foundation

public extension Data {
  
  func JSONRepresentation() -> [String: Any]? {
    if let dataString = String(data: self, encoding: String.Encoding.utf8) {
      return dataString.JSONConvertToDictionary()
    }
    return nil
  }
    
  private func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      } catch {
      }
    }
    return nil
  }
  
}

public extension String {
    
    func JSONConvertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
