//
//  SudokuAlgorithm.swift
//  AlgoVis
//
//  Created by Yash on 25/12/24.
//

import Foundation
import SwiftUI

extension SudokuSolver {
    func solve(_ r: Int = 0, _ c: Int = 0) -> Bool {
        var r = r, c = c
        while matrix[r][c] != -1 {
            c += 1
            if c == 9 {
                c = 0
                r += 1
                if r == 9 {
                    return true
                }
            }
        }
        for i in 1 ... 9 {
            if isValid(r, c, i) {
                matrix[r][c] = i
                usleep(UPDATE_DELAY)
                if !solve(r, c) {
                    matrix[r][c] = -1
                } else {
                    return true
                }
            }
        }
        return false
    }

    func isValid(_ row: Int, _ col: Int, _ val: Int) -> Bool {
        guard row < 9 && col < 9 else { return false }
        // Each of the digits 1-9 must occur exactly once in each row.
        for r in 0 ..< 9 {
            if matrix[r][col] == val {
                return false
            }
        }
        // Each of the digits 1-9 must occur exactly once in each column.
        for c in 0 ..< 9 {
            if matrix[row][c] == val {
                return false
            }
        }
        // Each of the digits 1-9 must occur exactly once in each of the 9 3x3 sub-boxes of the grid.
        let boxRowStart = (row / 3) * 3
        let boxColStart = (col / 3) * 3
        let boxRowEnd = boxRowStart + 2
        let boxColEnd = boxColStart + 2
        for r in boxRowStart ... boxRowEnd {
            for c in boxColStart ... boxColEnd {
                if matrix[r][c] == val { return false }
            }
        }
        return true
    }
}

#Preview {
    SudokuSolver()
}
