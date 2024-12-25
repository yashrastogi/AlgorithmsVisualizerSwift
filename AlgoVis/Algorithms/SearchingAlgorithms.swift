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
                usleep(UPDATE_DELAY)
                highlightCell.0.removeAll()
                highlightCell.0.insert(i)
                highlightCell.1 = 1
                break
            } else {
                highlightCell.0.insert(i)
                highlightCell.1 = 0
            }
            usleep(UPDATE_DELAY)
        }
    }

    func binarySearch(_ searchNum: Int) {
        highlightCell.1 = 0
        sleep(2)
        matrix.sort()
        var lo = 0
        var hi = ARR_SIZE - 1
        while lo <= hi {
            usleep(UPDATE_DELAY * 3)
            let mid = (lo + hi) / 2
            highlightCell.0.removeAll()
            for i in lo ... hi {
                highlightCell.0.insert(i)
            }
            if matrix[mid] == searchNum {
                usleep(UPDATE_DELAY * 3)
                highlightCell.0.removeAll()
                highlightCell.0.insert(mid)
                highlightCell.1 = 1
                break
            } else if matrix[mid] < searchNum {
                lo = mid + 1
            } else {
                hi = mid - 1
            }
        }
    }
}

#Preview {
    SearchingVisualizer()
}
