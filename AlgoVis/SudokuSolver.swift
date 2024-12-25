//
//  SudokuSolver.swift
//  AlgoVis
//
//  Created by Yash on 24/12/24.
//

import SwiftUI

struct SudokuSolver: View {
    let SIZE_OF_BOARD = 9
    let UPDATE_DELAY: UInt32 = 1000
    @State var matrix: [[Int]] = []
    @State var isRunning: Bool = false

    init() {
        _matrix = State(initialValue: generateMatrix())
    }

    func generateMatrix() -> [[Int]] {
        let rows = 9
        let columns = 9
        var matrix: [[Int]] = Array(repeating: Array(repeating: -1, count: SIZE_OF_BOARD), count: SIZE_OF_BOARD)
        var val = 1
        while val < 10 {
            matrix[Int.random(in: 0 ... 8)][Int.random(in: 0 ... 8)] = val
            val += 1
        }
        return matrix
        // let test = [
        //     [5, 3, -1, -1, 7, -1, -1, -1, -1],
        //     [6, -1, -1, 1, 9, 5, -1, -1, -1],
        //     [-1, 9, 8, -1, -1, -1, -1, 6, -1],
        //     [8, -1, -1, -1, 6, -1, -1, -1, 3],
        //     [4, -1, -1, 8, -1, 3, -1, -1, 1],
        //     [7, -1, -1, -1, 2, -1, -1, -1, 6],
        //     [-1, 6, -1, -1, -1, -1, 2, 8, -1],
        //     [-1, -1, -1, 4, 1, 9, -1, -1, 5],
        //     [-1, -1, -1, -1, 8, -1, -1, 7, 9],
        // ]
        // return test
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Button(action: {
                        isRunning = true
                        DispatchQueue.global().async {
                            print(solve())
                            isRunning = false
                        }
                    }) {
                        Text("Start")
                    }.disabled(isRunning)

                    Button(action: {
                        matrix = generateMatrix()
                    }) {
                        Text("Reset")
                    }
                    .disabled(isRunning)
                }

                VStack(spacing: 0) {
                    ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { row in
                        row % 3 == 0 ? Spacer().frame(height: 5).background(Color.white) : nil
                        HStack(spacing: 0) {
                            ForEach(0 ..< SIZE_OF_BOARD, id: \.self) { col in
                                col % 3 == 0 ? Spacer().frame(width: 5).background(Color.white) : nil
                                HStack {
                                    RoundedRectangle(cornerRadius: 0)
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            matrix[row][col] == -1 ? Text("") :
                                                Text("\(matrix[row][col])").foregroundColor(.white))
                                        .border(Color.white.opacity(1))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .padding()
            .navigationTitle("Sudoku Solver")
        }
    }
}

#Preview {
    SudokuSolver()
}
