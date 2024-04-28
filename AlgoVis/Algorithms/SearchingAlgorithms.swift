//
//  SearchingAlgorithms.swift
//  AlgoVis
//
//  Created by Yash on 28/04/24.
//

import Foundation
import SwiftUI

extension SearchingVisualizer {
  func linearSearch(_ searchNum: Int) {
    for (i, num) in matrix.enumerated() {
      if num == searchNum {
        // found
      }
    }
  }

  func binarySearch(_ searchNum: Int) {

  }
}

#Preview {
  SearchingVisualizer()
}
