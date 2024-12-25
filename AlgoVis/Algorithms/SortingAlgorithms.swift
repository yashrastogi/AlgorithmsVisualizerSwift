//
//  SortingAlgorithms.swift
//  AlgoVis
//
//  Created by Yash on 26/04/24.
//

import Foundation
import SwiftUI

extension SortingVisualizer {
    func mergeSort() {}

    func insertionSort() {
        var left = 0
        for i in 1 ..< matrixSize {
            if matrix[i - 1] > matrix[i] {
                let temp = matrix[i]
                matrix[i] = matrix[i - 1]
                matrix[i - 1] = temp
                left += 1
                // add a delay to see updates in progress
                usleep(UPDATE_DELAY)
                for j in stride(from: left - 1, to: 0, by: -1) {
                    if matrix[j - 1] > matrix[j] {
                        let temp = matrix[j]
                        matrix[j] = matrix[j - 1]
                        matrix[j - 1] = temp
                        // add a delay to see updates in progress
                        usleep(UPDATE_DELAY)
                    }
                }
            } else {
                left += 1
            }
        }
    }

    func bubbleSort() {
        for i in 0 ..< matrixSize {
            for j in i + 1 ..< matrixSize {
                if matrix[i] > matrix[j] {
                    let temp = matrix[i]
                    matrix[i] = matrix[j]
                    matrix[j] = temp
                    // add a delay to see updates in progress
                    usleep(UPDATE_DELAY)
                }
            }
        }
    }
}

#Preview {
    SortingVisualizer()
    //    .frame(width: 350, height: 550)
}
