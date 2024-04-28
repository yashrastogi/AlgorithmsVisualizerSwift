//
//  nQueensAlgorithm.swift
//  AlgoVis
//
//  Created by Yash on 27/04/24.
//

import Foundation
import SwiftUI

extension NQueensVisualizer {
  func nQueens(_ row: Int = 0) {
    guard row < SIZE_OF_BOARD else { return }
    for col in 0..<SIZE_OF_BOARD {
      statusUpdates.insert("Trying row \(row) and col \(col): ", at: 0)
      if !isClashing(row, col) {
        statusUpdates[0] += "Successful\n"
        matrix[row][col] = true
        usleep(UPDATE_DELAY)
        nQueens(row + 1)
        break
      } else {
        statusUpdates[0] += "Failed\n"
        matrix[row][col] = true
        usleep(UPDATE_DELAY)
        matrix[row][col] = false
      }
    }
  }

  func isClashing(_ row: Int, _ col: Int) -> Bool {
    guard row < SIZE_OF_BOARD && col < SIZE_OF_BOARD && row >= 0 && col >= 0 else { return false }
    for (d1, d2) in [(0, 1), (1, 0), (1, 1), (0, -1), (-1, 0), (-1, -1), (-1, 1), (1, -1)] {
      var nRow = row + d1
      var nCol = col + d2
      while nRow >= 0 && nCol >= 0 && nRow < SIZE_OF_BOARD && nCol < SIZE_OF_BOARD {
        if matrix[nRow][nCol] {
          return true
        }
        nRow += d1
        nCol += d2
      }

    }
    return false
  }
}

#Preview {
  NQueensVisualizer()
}
